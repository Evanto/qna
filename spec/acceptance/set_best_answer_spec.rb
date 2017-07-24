require_relative 'acceptance_helper'

feature 'Set best answer', %q{
  In order to pick the best answer
  as an author of a question
  I want to be able to select the best answer
} do

  given(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answers) { create_list(:answer, 3, question: question) }

  senario 'Unauthed user tries to select an answer' do
    visit question_path(question)

    within '.answers' do
      
    end
  end

end
