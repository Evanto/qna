require_relative 'acceptance_helper'

feature 'Set best answer', %q{
  In order to pick the best answer
  as an author of a question
  I want to be able to select the best answer
} do

  given(:user)      { create(:user) }
  given(:user2)     { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answer1)  { create(:answer, question: question) }
  given!(:answer2)  { create(:answer, question: question) }

  scenario 'Authed Question author sets the best answer', js: true do
    sign_in(user)
    visit question_path(question)

    within "div.answer-#{answer1.id}" do
      click_on 'set best'

      expect(page).to have_css '.glyphicon-star'
      expect(page).to_not have_link 'set best'
    end
      expect(page).to have_link 'set best'
    end

  scenario 'Authed question non-author tries to set the best answer', js: true do
    sign_in(user2)
    visit question_path(question)

    expect(page).to_not have_link 'set best'
  end

  scenario 'Unauthed user doesnt see set best links' do
    visit question_path(question)

    within '.answers' do
      expect(page).to_not have_link 'set best'
    end
  end

  scenario 'Authed question author changes best answer', js: true do
    sign_in(user)
    answer3 = question.answers.last
    answer4 = create(:answer, question: question, best: true)
    visit question_path(question)

    within '.answers' do
      within "div.answer-#{answer3.id}" do
        click_on 'set best'
      end

      #expect(question.answers.first.id).to have_css '.glyphicon-star'
      expect(page.first(:css, 'div')).to have_css '.glyphicon-star'
    end
  end
end
