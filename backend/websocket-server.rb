require 'em-websocket'

require 'project-name/websocket/message-handler'

EM.run do
  EM::WebSocket.run(host: "0.0.0.0", port: 8081) do |ws|
    ws.onopen do |handshake|
      puts "Websocket open"
    end

    ws.onclose do
      puts "Websocket closed!"
    end

    ws.onmessage do |json_payload|
      begin
        handler = ProjectName::Websocket::MessageHandler.new(
          websocket: ws,
          json_payload: json_payload
        )
        handler.handle
      rescue StandardError => e
        $stderr.puts "*" * 79
        $stderr.puts "ERROR onmessage:"
        $stderr.puts e.inspect
        $stderr.puts "Payload: #{json_payload}"
        $stderr.puts e.backtrace.reject { |line| line =~ %r</gems/> }.join("\n\t")
      end
    end
  end
end
