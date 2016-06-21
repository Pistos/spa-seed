require 'json'

module ProjectName
  module Websocket
    module Handler
      class Direct
        def initialize(websocket:, websocket_message_id:, **args)
          @websocket, @websocket_message_id = websocket, websocket_message_id
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
              'id' => @websocket_message_id,
              'response' => response,
            }.to_json
          )
        end
      end
    end
  end
end
