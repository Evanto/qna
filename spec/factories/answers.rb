FactoryGirl.define do
  factory :answer do
    body "Test answer"
    association :question, factory: :question
  end
  factory :invalid_, class: "Question" do
    title nil
    body nil
  end
end
