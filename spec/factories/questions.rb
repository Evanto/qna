FactoryGirl.define do
  factory :question do
    title "MyString"
    body "MyText"
    user
  end

  factory :invalid_question, class: "Question" do
    title nil
    body nil
    user
  end
end
