FactoryGirl.define do
  factory :answer do
    body "Test answer"
    question
    user
    #association :question, factory: :question
  end
  factory :invalid_answer, class: "Answer" do
    body nil
    question
    user
  end
end
