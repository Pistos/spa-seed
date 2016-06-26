FactoryGirl.define do
  factory :restricted_thing, class: ProjectName::Model::RestrictedThing do
    name 'Test Restricted Thing'

    trait :owned do
      owner_user_id { FactoryGirl.create(:user).id }
    end
  end
end
