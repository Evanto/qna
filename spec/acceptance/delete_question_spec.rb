require_relative 'acceptance_helper'

feature 'Delete Question', %q{
  In order to delete question from website
  As an authentificated user
  I want to be able to delete my question
} do

  given(:user) { create(:user) }
  given(:user1) { create(:user) }
  given!(:question) { create(:question, user: user) }

  scenario 'Authentificated user deletes his question' do
    sign_in(user)

    visit question_path(question)
    expect(page).to have_content question.title
    expect(page).to have_content question.body
    click_on 'Delete'

    expect(page).to have_content 'Your question was successfully deleted.'
    expect(page).not_to have_content question.title
    expect(page).not_to have_content question.body
  end

  scenario 'Authentificated user deletes others question' do
    sign_in(user1)

    visit question_path(question)

    expect(page).not_to have_content 'delete question'
  end

  scenario 'Non-authentificated user tries to delete question' do
    visit question_path(question)

    expect(page).not_to have_content 'delete question'
  end

end
