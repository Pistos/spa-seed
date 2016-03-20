require 'json'

module ProjectName
  module Websocket
    module Handler
      class Direct
        # TODO: Rename id to something more descriptive?
        def initialize(websocket:, id:, **args)
          @websocket, @id = websocket, id
          initialize_more(**args)
        end

        def initialize_more(**args)
          nil
        end

        def response
          nil
        end

        def respond
          @websocket.send(
            {
              'id' => @id,
              'response' => response,
            }.to_json
          )
        end
      end
    end
  end
end
