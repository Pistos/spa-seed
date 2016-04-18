require 'project-name/websocket/authenticatable-websocket'

module ProjectName
  module Websocket
    class AuthenticatableWebsocketSet
      def initialize
        @set = []
      end

      def <<(websocket)
        @set << Websocket::AuthenticatableWebsocket(websocket)
      end

      def delete(websocket)
        @set.delete self[websocket]
      end

      def each(*args, &block)
        @set.each(*args, &block)
      end

      def [](websocket)
        @set.find { |aws| aws == websocket || aws.websocket == websocket }
      end
    end
  end
end
