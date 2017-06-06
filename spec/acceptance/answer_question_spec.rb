require 'rails_helper'

feature 'User answers a question', %q{
  In order to answer a question
  I want to be able to fill the answer form on a page of a question
} do

given(:question) { create(:question) }
given(:user) { create(:user) }

scenario 'Authenticated user answers a question' do
  sign_in(user)
  visit question_path(id: question.id)
  fill_in 'Body', with: 'Test answer'
  click_on 'Post your answer'

  expect(page).to have_content 'Test answer'
end

end
