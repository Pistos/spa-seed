FactoryGirl.define do
  factory :user, class: ProjectName::Model::User do
    sequence(:username) { |n| "testuser#{n}" }
    encrypted_password BCrypt::Password.create('testpassword')
  end
end
