require 'rails_helper'

feature 'Create question', %q{
  In order to get answers from a community
  as an authenticated user I want to be able to ask questions
} do

  given(:user) { create(:user) }

  scenario 'Authenticated user creates a question' do
    sign_in(user)

    visit questions_path # юзер должен зайти на страницу индек всех вопросов
    click_on 'Ask question'
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'Test body'
    click_on 'Create'

    expect(page).to have_content 'Your question was successfully created.'
  end

  scenario 'Non-authenticated user tries to create a question' do
    visit questions_path
    click_on 'Ask question'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

end
