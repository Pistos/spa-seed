require 'project-name/model'
require 'project-name/websocket/handler/direct'

module ProjectName
  module Websocket
    module Handler
      module Things
        class List < Handler::Direct
          def response
            Model::Thing.all.map(&:to_serializable)
          end
        end
      end
    end
  end
end
