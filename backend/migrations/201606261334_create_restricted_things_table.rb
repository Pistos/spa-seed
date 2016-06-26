Sequel.migration do
  change do
    create_table(:restricted_things) do
      primary_key :id
      String :name, null: false
      foreign_key :owner_user_id, :users
    end
  end
end
