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

      def initialize(websocket:, json_payload:)
        @ws = websocket

        payload = JSON.parse(json_payload)
        puts "Handling message: \n#{payload.inspect}"

        @id, @message, @args = payload['id'], payload['message'], payload['args']
      end

      def handle
        if ! UNAUTHENTICATED_MESSAGES.include?(@message) && ! authenticated?
          response = { 'error' => 'Unauthorized' }
        else
          response = message_handler.respond
        end

        @ws.send(
          {
            'id' => @id,
            'response' => response
          }.to_json
        )
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
            username: @args['username'].to_s,
            password: @args['password'].to_s
          )
        when '/users/authentications/create'
          Websocket::Handler::Users::Authentications::Create.new(
            username: @args['username'].to_s,
            password: @args['password'].to_s
          )
        when '/things'
          Websocket::Handler::Things::List.new
        when '/things/create'
          Websocket::Handler::Things::Create.new(
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
