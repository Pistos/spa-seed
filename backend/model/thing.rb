module Model
  class Thing < Sequel::Model
    def to_serializable
      {
        'id' => self.id,
        'name' => self.name,
        'description' => self.description,
      }
    end
  end
end
