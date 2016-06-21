require 'project-name/model'
require 'project-name/websocket/handler/broadcasting'

module ProjectName
  module Websocket
    module Handler
      module Things
        class Create < Handler::Broadcasting
          def initialize_more(name:, description:)
            Model::Thing.create(
              name: name,
              description: description
            )
          end
        end
      end
    end
  end
end
