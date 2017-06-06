FactoryGirl.define do
  factory :answer do
    question
    body "Test answer"
    user
    #association :question, factory: :question
  end
  
  factory :invalid_answer, class: "Answer" do
    body nil
    question
    user
  end
end
