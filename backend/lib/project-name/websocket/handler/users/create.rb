require 'jwt'
require 'project-name/model'
require 'project-name/websocket/handler/direct'

module ProjectName
  module Websocket
    module Handler
      module Users
        class Create < Handler::Direct
          def initialize_more(username:, password:)
            Model::User.create_with_creds(
              username: username,
              plaintext_password: password
            )
          end

          def response
            { 'success' => true }
          end
        end
      end
    end
  end
end
