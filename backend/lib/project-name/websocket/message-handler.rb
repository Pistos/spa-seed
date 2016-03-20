require 'json'
require 'jwt'

require 'project-name/websocket/handlers'

module ProjectName
  module Websocket
    class MessageHandler
      UNAUTHENTICATED_MESSAGES = [
        '/users/create',
        '/users/authentications/create',
      ]

      def initialize(broadcaster:, websocket:, json_payload:, logger: $stdout)
        @broadcaster, @websocket = broadcaster, websocket

        payload = JSON.parse(json_payload)
        logger.puts "Handling message: \n#{payload.inspect}"

        @id, @message, @args = payload['id'], payload['message'], payload['args']
      end

      def handle
        if ! UNAUTHENTICATED_MESSAGES.include?(@message) && ! authenticated?
          # TODO: What about authenticated broadcast handling?
          # (This is responding like a direct handler)
          # So maybe this error stuff belongs in the individual handlers.
          # Ruby module or something.
          # Or composition?  Authenticator class?
          @websocket.send(
            {
              'id' => @id,
              'response' => { 'error' => 'Unauthorized' }
            }.to_json
          )
        else
          message_handler.respond
        end
      end

      private

      def current_user
        return @current_user  if @current_user

        begin
          jwt_payload = JWT.decode(
            @args['jwt'].to_s,
            $conf['jwt_secret']
          )
          if jwt_payload
            @current_user = Model::User[id: jwt_payload[0]['user_id'].to_i]
          end
        rescue JWT::DecodeError
          nil
        end
      end

      def authenticated?
        current_user
      end

      def message_handler
        case @message
        when '/users/create'
          Websocket::Handler::Users::Create.new(
            websocket: @websocket,
            id: @id,
            username: @args['username'].to_s,
            password: @args['password'].to_s
          )
        when '/users/authentications/create'
          Websocket::Handler::Users::Authentications::Create.new(
            websocket: @websocket,
            id: @id,
            username: @args['username'].to_s,
            password: @args['password'].to_s
          )
        when '/things'
          Websocket::Handler::Things::List.new(
            websocket: @websocket,
            id: @id
          )
        when '/things/create'
          Websocket::Handler::Things::Create.new(
            broadcaster: @broadcaster,
            name: @args['name'].to_s,
            description: @args['description'].to_s
          )
        else
          Websocket::Handler::Null.new
        end
      end
    end
  end
end
