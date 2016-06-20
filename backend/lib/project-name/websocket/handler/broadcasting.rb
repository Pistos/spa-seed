module ProjectName
  module Websocket
    module Handler
      class Broadcasting
        def initialize(broadcaster:, **args)
          @broadcaster = broadcaster
          initialize_more(**args)
        end

        def initialize_more(**args)
          nil
        end

        def message
          nil
        end

        def response
          nil
        end

        def respond
          @broadcaster.broadcast(
            {
              'message' => message,
              # 'args'?
              'response' => response,
            }.to_json
          )
        end
      end
    end
  end
end
