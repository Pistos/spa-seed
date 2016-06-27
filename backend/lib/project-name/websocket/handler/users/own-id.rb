require 'project-name/model'
require 'project-name/websocket/handler/direct'

module ProjectName
  module Websocket
    module Handler
      module Users
        class OwnId < Handler::Direct
          def response
            { 'user_id' => @websocket.user.id, }
          end
        end
      end
    end
  end
end
