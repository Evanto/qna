require 'rails_helper'

feature 'User deletes answer', %q{
In order to remove my answer
I want to be able to delete answers, of which I am the author
} do

  given!(:user) { create(:user) }
given!(:question) { create(:question, user: user) }
given!(:answer) { create(:answer, user: user, question: question)}
scenario 'User can delete his answer' do
  sign_in(user)
  visit question_path question
  answer_body = answer.body

  click_on 'delete answer'
  expect(page).to have_content 'Answer successfully deleted'
  expect(page).to have_no_content 'answer_body'

end

scenario 'User cant delete other user answer'do
  other_user = create(:user)
  sign_in(other_user)
  visit question_path question

  expect(page).to have_no_content 'delete answer'
end

end
