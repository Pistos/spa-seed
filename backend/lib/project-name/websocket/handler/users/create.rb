require 'jwt'
require 'project-name/model'

module ProjectName
  module Websocket
    module Handler
      module Users
        class Create
          def initialize(username:, password:)
            @username, @password = username, password
          end

          def respond
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
