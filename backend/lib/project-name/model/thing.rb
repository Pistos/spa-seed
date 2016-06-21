require 'project-name/model/base'

module ProjectName
  module Model
    class Thing < Model::Base
      def to_serializable
        {
          'id' => self.id,
          'name' => self.name,
          'description' => self.description,
        }
      end

      def visible_to?(user:)
        true
      end
    end
  end
end
