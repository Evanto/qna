require 'rails_helper'

feature 'User answers a question', %q{
  In order to answer a question
  I want to be able to fill the answer form on a page of a question
} do

  given(:user)     { create(:user) }
  given(:question) { create(:question) }

  scenario 'Authenticated user answers a question' do
    sign_in(user)
    visit question_path(question)

    expect(page).to have_content question.title
    expect(page).to have_content question.body

    fill_in  'Answer', with: 'My answer'
    click_on 'Post your answer'

    expect(page).to have_content 'Your answer was successfully created.'
    expect(page).to have_content 'My answer'
  end

  scenario 'Non-authenticated user answers a question' do
    visit question_path(question)

    expect(page).to have_content question.title
    expect(page).to have_content question.body

    expect(page).not_to have_content 'Post your answer'
  end

  scenario 'Authenticated user tries to post an empty answer' do
    sign_in(user)
    visit question_path(question)

    expect(page).to have_content question.title
    expect(page).to have_content question.body

    click_on 'Post your answer'

    expect(page).to have_content "Body can't be blank"

 end
end
