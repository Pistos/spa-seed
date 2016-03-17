require 'json'
require 'jwt'

require 'project-name/config'
require 'project-name/model'

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
        response = nil

        case @message
        when '/things'
          response = Model::Thing.all.map(&:to_serializable)
        when '/things/create'
          response = Model::Thing.create(
            name: @args['name'],
            description: @args['description']
          ).to_serializable
        end

        @ws.send(
          {
            'id' => @id,
            'response' => response
          }.to_json
        )
      end
    end
  end
end
