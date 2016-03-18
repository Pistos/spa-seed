require 'jwt'
require 'project-name/model'

module ProjectName
  module Websocket
    module Handler
      module Users
        module Authentications
          class Create
            def initialize(username:, password:)
              @username, @password = username, password
            end

            def respond
              user = Model::User.find_by_creds(
                username: @username,
                plaintext_password: @password
              )
              if user
                payload = { 'user_id' => user.id }
                { 'jwt' => JWT.encode(payload, $conf['jwt_secret']) }
              else
                { 'error' => 'No user found' }
              end
            end
          end
        end
      end
    end
  end
end
