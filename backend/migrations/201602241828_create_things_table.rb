Sequel.migration do
  change do
    create_table(:things) do
      primary_key :id
      String :name, null: false
      String :description, null: false
    end
  end
end
