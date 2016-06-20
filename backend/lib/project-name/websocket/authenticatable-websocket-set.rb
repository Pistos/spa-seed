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
        aws = self[websocket]
        user = aws.user

        @set.delete aws

        if no_more_sockets_for_user?(user)
          user
        end
      end

      def each(*args, &block)
        @set.each(*args, &block)
      end

      def [](websocket)
        @set.find { |aws| aws == websocket || aws.websocket == websocket }
      end

      private

      def no_more_sockets_for_user?(user)
        @set.none? { |aws|
          aws.user == user
        }
      end
    end
  end
end
