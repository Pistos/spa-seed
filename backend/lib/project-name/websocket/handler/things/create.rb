require 'project-name/model'
require 'project-name/websocket/handler/broadcasting'

module ProjectName
  module Websocket
    module Handler
      module Things
        class Create < Handler::Broadcasting
          def initialize_more(name:, description:)
            @name, @description = name, description
          end

          def message
            '/things/create'
          end

          def response
            Model::Thing.create(
              name: @name,
              description: @description
            ).to_serializable
          end
        end
      end
    end
  end
end
