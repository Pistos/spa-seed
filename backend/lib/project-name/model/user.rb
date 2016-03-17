require 'bcrypt'

module ProjectName
  module Model
    class User < Sequel::Model
      def password
        BCrypt::Password.new(self.encrypted_password)
      end

      def password=(new_password)
        self.encrypted_password = BCrypt::Password.create(new_password)
      end

      def self.create_with_creds(username:, plaintext_password:)
        encrypted_password = BCrypt::Password.create(plaintext_password)
        self.create(
          username: username,
          encrypted_password: encrypted_password
        )
      end

      def self.find_by_creds(username:, plaintext_password:)
        user = Model::User[username: username]
        user  if user.password == plaintext_password
      end
    end
  end
end
