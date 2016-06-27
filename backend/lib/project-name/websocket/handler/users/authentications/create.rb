require 'jwt'
require 'project-name/model'
require 'project-name/jwt'
require 'project-name/websocket/handler/direct'

module ProjectName
  module Websocket
    module Handler
      module Users
        module Authentications
          class Create < Handler::Direct
            def initialize_more(username:, password:)
              @username, @password = username, password
            end

            def response
              user = Model::User.find_by_creds(
                username: @username,
                plaintext_password: @password
              )

              if user
                { 'jwt' => ProjectName::JWT.for(user: user) }
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
