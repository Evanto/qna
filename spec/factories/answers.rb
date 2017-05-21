FactoryGirl.define do
  factory :answer do
    body "Test answer"
    association :question, factory: :question
  end
end
