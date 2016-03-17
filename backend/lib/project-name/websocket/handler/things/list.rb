require 'project-name/model'

module ProjectName
  module Websocket
    module Handler
      module Things
        class List
          def respond
            Model::Thing.all.map(&:to_serializable)
          end
        end
      end
    end
  end
end
