require 'json'
require 'jwt'

require 'project-name/websocket/handlers'

module ProjectName
  module Websocket
    class MessageHandler
      def initialize(websocket:, json_payload:)
        @ws = websocket

        payload = JSON.parse(json_payload)
        puts "Handling message: \n#{payload.inspect}"

        @id, @message, @args = payload['id'], payload['message'], payload['args']
      end

      def handle
        @ws.send(
          {
            'id' => @id,
            'response' => message_handler.respond
          }.to_json
        )
      end

      def message_handler
        case @message
        when '/users/authentications/create'
          Websocket::Handler::Users::Authentications::Create.new(
            username: @args['username'],
            password: @args['password']
          )
        when '/things'
          Websocket::Handler::Things::List.new
        when '/things/create'
          Websocket::Handler::Things::Create.new(
            name: @args['name'],
            description: @args['description']
          )
        end
      end
    end
  end
end
