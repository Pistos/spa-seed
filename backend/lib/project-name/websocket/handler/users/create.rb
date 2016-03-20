require 'jwt'
require 'project-name/model'
require 'project-name/websocket/handler/direct'

module ProjectName
  module Websocket
    module Handler
      module Users
        class Create < Handler::Direct
          def initialize_more(username:, password:)
            @username, @password = username, password
          end

          # XXX: Is it right that something called "response"
          # does actual work / mutates stuff?
          def response
            Model::User.create_with_creds(
              username: @username,
              plaintext_password: @password
            )

            { 'success' => true }
          end
        end
      end
    end
  end
end
