require 'project-name/model'
require 'project-name/websocket/handler/broadcasting'

module ProjectName
  module Websocket
    module Handler
      module Things
        # TODO: This should probably be a Handler::Direct
        class Delete < Handler::Direct
          def initialize_more(id:)
            Model::Thing.where(id: id).destroy
          end
        end
      end
    end
  end
end
