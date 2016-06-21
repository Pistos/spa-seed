require 'json'
require 'jwt'

require 'project-name/model'

module ProjectName
  module Websocket
    def self.AuthenticatableWebsocket(websocket)
      if websocket.respond_to? :authenticate
        websocket
      else
        AuthenticatableWebsocket.new websocket: websocket
      end
    end

    class AuthenticatableWebsocket
      attr_reader :websocket

      def initialize(websocket:)
        @websocket = websocket
      end

      def authenticate(json_payload)
        payload = JSON.parse(json_payload)
        jwt = payload['jwt'].to_s

        begin
          jwt_payload = JWT.decode(
            jwt,
            $conf['jwt_secret']
          )
          if jwt_payload
            @user = Model::User[id: jwt_payload[0]['user_id'].to_i]
          end
        rescue JWT::DecodeError
        end
      end

      def send(*args)
        @websocket.send *args
      end

      def authenticated?
        @user
      end

      def user
        @user ||= Model::NilUser.new
      end
    end
  end
end
