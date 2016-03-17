require 'project-name/model'

module ProjectName
  module Websocket
    module Handler
      module Things
        class Create
          def initialize(name:, description:)
            @name, @description = name, description
          end

          def respond
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
