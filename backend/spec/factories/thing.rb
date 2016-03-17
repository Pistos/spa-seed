FactoryGirl.define do
  factory :thing, class: ProjectName::Model::Thing do
    name "Test Thing"
    description "A thing created for testing the code."
  end
end
