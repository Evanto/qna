require 'rails_helper'

feature 'User views question with answers', %q{
  In order to read questions and answers
  I want to be able view question's show page with all answers
} do

  given(:question) { create :question }
  given(:answers) { create_list(:answer, 3, question: question) }

  scenario 'User opens one of the questions show pages' do
    visit question_path(question)

    expect(page).to have_content(question.title)
    expect(page).to have_content(question.body)

    question.answers.each do |answer|
      expect(page).to have_content(answer.body)
    end
  end
end
