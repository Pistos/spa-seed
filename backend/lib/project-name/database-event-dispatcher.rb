require 'set'

require 'project-name/database'
require 'project-name/database-event'

module ProjectName
  class DatabaseEventDispatcher
    OPERATIONS = [
      'insert',
      'update',
      'delete',
    ]

    def initialize
      @subscribers = Set.new

      ProjectName::Database.tables.map { |table|
        OPERATIONS.map { |operation|
          create_listener_thread(table: table, operation: operation)
        }
      }.flatten
    end

    def subscribe(subscriber:)
      @subscribers << subscriber
    end

    def unsubscribe(subscriber:)
      @subscribers.delete subscriber
    end

    private

    def create_listener_thread(table:, operation:)
      Thread.new do
        $db.listen("#{table}_#{operation}", loop: true) do |channel, _, payload|
          channel =~ /^(.+)_([a-z]+)$/
          event_table, event_operation = $1, $2

          @subscribers.each do |s|
            s.on_db_event(
              DatabaseEvent.new(
                table: event_table,
                operation: event_operation,
                payload: payload
              )
            )
          end
        end
      end
    end
  end
end

$db_event_dispatcher ||= ProjectName::DatabaseEventDispatcher.new
