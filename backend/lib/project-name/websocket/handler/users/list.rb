require 'project-name/model'
require 'project-name/websocket/handler/direct'

module ProjectName
  module Websocket
    module Handler
      module Users
        class List < Handler::Direct
          def response
            Model::User.all.map(&:to_serializable)
          end
        end
      end
    end
  end
end
