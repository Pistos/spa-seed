require 'project-name/model'

module ProjectName
  class DataBroker
    MODEL_FOR = {
      'things' => Model::Thing,
      'users' => Model::User,
    }

    def initialize(user:, event_receiver:)
      @user = user
      @event_receiver = event_receiver
      $db_event_dispatcher.subscribe(subscriber: self)
    end

    def on_db_event(event)
      puts "DataBroker for user #{@user.id} received DB event: #{event.table}##{event.operation}"

      # WIP:
      # We'll probably want individual classes to delegate to here,
      # instead of a case tree

      model = MODEL_FOR[event.table]

      case event.operation
      when 'insert'
        require 'pry-byebug'; debugger
        record = model[event.payload.to_i]
        if record.visible_to?(user: @user)
          @event_receiver.broadcast_to_user(
            user: @user,
            payload: record.to_serializable.to_json
          )
        end
      # when 'update'
      # when 'delete'
      end
    end
  end
end
