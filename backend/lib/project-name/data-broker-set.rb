require 'project-name/data-broker'

module ProjectName
  class DataBrokerSet
    def initialize(event_receiver:)
      @event_receiver = event_receiver
      @data_brokers = {}
    end

    def register(user:)
      @data_brokers[user] ||= user.new_data_broker(@event_receiver)
    end

    def deregister(user:)
      broker = @data_brokers.delete(user)
      # /!\ This may not be necessary, as the GC may take care of it.
      # It's also odd that we reference $db_event_dispatcher outside the
      # DataBroker here, but inside the DataBroker on construction.
      $db_event_dispatcher.unsubscribe(subscriber: broker)
    end
  end
end
