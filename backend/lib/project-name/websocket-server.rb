require 'project-name/database-event-dispatcher'
require 'project-name/data-broker-set'
require 'project-name/null-logger'
require 'project-name/websocket/authenticatable-websocket-set'
require 'project-name/websocket/message-handler'

module ProjectName
  class WebsocketServer
    attr_reader :auth_websockets

    def initialize
      @auth_websockets = Websocket::AuthenticatableWebsocketSet.new
      @data_brokers = DataBrokerSet.new(event_receiver: self)
      @logger = $stdout
      @logger_error = $stderr
    end

    def run(ws)
      ws.onopen do |handshake|
        @logger.puts "Websocket open"
        @auth_websockets << ws
      end

      ws.onclose do
        nil_or_user_with_no_more_sockets = @auth_websockets.delete(ws)
        @data_brokers.deregister user: nil_or_user_with_no_more_sockets
        @logger.puts "Websocket closed!"
      end

      ws.onmessage do |json_payload|
        begin
          aws = @auth_websockets[ws]
          aws.authenticate(json_payload)
          @data_brokers.register user: aws.user
          handler = ProjectName::Websocket::MessageHandler.new(
            broadcaster: self,
            websocket: aws,
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
      @auth_websockets.each do |ws|
        ws.send payload
      end
    end

    def broadcast_to_user(user:, payload:)
      @auth_websockets.each do |ws|
        if ws.user == user
          ws.send payload
        end
      end
    end
  end
end

