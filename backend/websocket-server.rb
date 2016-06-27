require 'em-websocket'

require 'project-name/websocket-server'

Thread.abort_on_exception = true

if $conf.env == 'development'
  require 'pry-byebug'
end

EventMachine.run do
  puts "Websocket server started"
  puts "Environment: #{$conf.env.inspect}"

  server = ProjectName::WebsocketServer.new

  EventMachine::WebSocket.run(host: "0.0.0.0", port: 8081) do |ws|
    server.run(ws)
  end
end
