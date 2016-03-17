require 'em-websocket'
require 'json'
require 'jwt'

require 'project-name/config'
require 'project-name/model'

EM.run do
  EM::WebSocket.run(host: "0.0.0.0", port: 8081) do |ws|
    ws.onopen do |handshake|
      puts "Websocket open"
    end

    ws.onclose do
      puts "Websocket closed!"
    end

    ws.onmessage do |json_payload|
      payload = JSON.parse(json_payload)
      puts "onmessage\n#{payload.inspect}"
      id, message, args = payload['id'], payload['message'], payload['args']
      response = nil

      case message
      when '/things'
        response = ProjectName::Model::Thing.all.map(&:to_serializable)
      when '/things/create'
        response = ProjectName::Model::Thing.create(
          name: args['name'],
          description: args['description']
        ).to_serializable
      end

      ws.send(
        {
          'id' => id,
          'response' => response
        }.to_json
      )
    end
  end
end
