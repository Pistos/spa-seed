FactoryGirl.define do
  factory :user, class: ProjectName::Model::User do
    username 'testuser'
    encrypted_password BCrypt::Password.create('testpassword')
  end
end
