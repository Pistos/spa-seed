Sequel.migration do
  change do
    create_table(:users) do
      primary_key :id
      String :username, null: false, unique: true
      String :encrypted_password, null: false
      constraint(:username_min_length) { char_length(username) > 0 }
    end
  end
end
