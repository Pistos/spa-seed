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
        if ! UNAUTHENTICATED_MESSAGES.include?(@message) && ! @websocket.authenticated?
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

      def message_handler
        case @message
        when '/users/create'
          Websocket::Handler::Users::Create.new(
            websocket: @websocket,
            websocket_message_id: @id,
            username: @args['username'].to_s,
            password: @args['password'].to_s
          )
        when '/users/authentications/create'
          Websocket::Handler::Users::Authentications::Create.new(
            websocket: @websocket,
            websocket_message_id: @id,
            username: @args['username'].to_s,
            password: @args['password'].to_s
          )
        when '/users'
          Websocket::Handler::Users::List.new(
            websocket: @websocket,
            websocket_message_id: @id
          )
        when '/users/own-id'
          Websocket::Handler::Users::OwnId.new(
            websocket: @websocket,
            websocket_message_id: @id
          )
        when '/things'
          Websocket::Handler::Things::List.new(
            websocket: @websocket,
            websocket_message_id: @id
          )
        when '/things/create'
          Websocket::Handler::Things::Create.new(
            websocket: @websocket,
            websocket_message_id: @id,
            name: @args['name'].to_s,
            description: @args['description'].to_s
          )
        when '/things/delete'
          Websocket::Handler::Things::Delete.new(
            websocket: @websocket,
            websocket_message_id: @id,
            id: @args['id'].to_i
          )
        else
          Websocket::Handler::Null.new
        end
      end
    end
  end
end
