require 'em-websocket'

require 'project-name/websocket-server'

EventMachine.run do
  puts "Websocket server started"

  server = ProjectName::WebsocketServer.new

  EventMachine::WebSocket.run(host: "0.0.0.0", port: 8081) do |ws|
    server.run(ws)
  end
end
