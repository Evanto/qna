FactoryGirl.define do
  factory :vote do
    user
    value 1
  end

  factory :invalid_vote, class: 'Vote' do
    user
    value 2
  end
end
