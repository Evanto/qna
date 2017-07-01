require_relative 'acceptance_helper'

feature 'User can view a list of all questions', %q{
  In order to look around as a visitor
  I want to be able to view the list of all questions
} do
  given(:user) { create(:user) }
  given!(:questions) { create_list(:question, 3) }

  scenario 'Authenticated User sees a list of questions' do
    sign_in(user)
    visit questions_path

    questions.each do |question|
      expect(page).to have_content question.title
    end
  end

  scenario 'Non-authenticated User sees a list of questions' do
    visit questions_path

    questions.each do |question|
      expect(page).to have_content question.title
    end
  end
end
