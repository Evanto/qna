FactoryGirl.define do
  sequence :body do |n|
    "answerbody #{n}"
  end

  factory :answer do
    question
    body
    user
    best false
  end

  factory :invalid_answer, class: "Answer" do
    body nil
    question
    user
    best false
  end
end
