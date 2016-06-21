module ProjectName
  module Model
    Base = Class.new(Sequel::Model)
    class Base
      def visible_to?(user:)
        false
      end
    end
  end
end
