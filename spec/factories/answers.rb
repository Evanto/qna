FactoryGirl.define do
  sequence :body do |n|
    "answerbody #{n}"
  end

  factory :answer do
    question
    body
    user
  end

  factory :invalid_answer, class: "Answer" do
    body nil
    question
    user
  end
end
