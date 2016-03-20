require 'project-name/null-logger'
require 'project-name/websocket/message-handler'

module ProjectName
  class WebsocketServer
    def initialize
      @websockets = []
      @logger = $stdout
      @logger_error = $stderr
    end

    def run(ws)
      ws.onopen do |handshake|
        @logger.puts "Websocket open"
        @websockets << ws
      end

      ws.onclose do
        @websockets.delete ws
        @logger.puts "Websocket closed!"
      end

      ws.onmessage do |json_payload|
        begin
          handler = ProjectName::Websocket::MessageHandler.new(
            broadcaster: self,
            websocket: ws,
            json_payload: json_payload,
            logger: @logger
          )
          handler.handle
        rescue StandardError => e
          @logger_error.puts "*" * 79
          @logger_error.puts "ERROR onmessage:"
          @logger_error.puts e.inspect
          @logger_error.puts "Payload: #{json_payload}"
          @logger_error.puts e.backtrace.reject { |line| line =~ %r</gems/> }.join("\n\t")
        end
      end
    end

    def broadcast(payload)
      @websockets.each do |ws|
        ws.send payload
      end
    end
  end
end

