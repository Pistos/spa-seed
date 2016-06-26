require 'project-name/model/base'
require 'project-name/model/user'

module ProjectName
  module Model
    class RestrictedThing < Model::Base
      many_to_one :owner, class: User, key: :owner_user_id

      def to_serializable
        {
          'id' => self.id,
          'name' => self.name,
          'owner_user_id' => self.owner_user_id,
        }
      end

      def visible_to?(user:)
        user == owner
      end
    end
  end
end
