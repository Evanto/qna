require_relative 'acceptance_helper'
  feature 'User can vote for questions', %q{
    In order to express my opinion about
    other users questions I want to be able to
    upvote/downvote questions and reset my vote
    as an authenticated user
    } do

      given(:user) { create(:user) }
      given!(:question) { create(:question) }

      scenario 'An authenticated non-author of a question votes for it', js: true do
        sign_in(user)
        visit questions_path

        click_on 'Up'
        expect(page).to have_content 'Rate: 1'
        expect(page).to have_content 'Reset'
        expect(page).to_not have_content 'Up'
        expect(page).to_not have_content 'Down'

        click_on 'Reset'
        expect(page).to have_content 'Rate: 0'
        expect(page).to_not have_content 'Reset'
        expect(page).to have_content 'Up'
        expect(page).to have_content 'Down'

        click_on 'Down'
        expect(page).to have_content 'Rate: -1'
        expect(page).to have_content 'Reset'
        expect(page).to_not have_content 'Up'
        expect(page).to_not have_content 'Down'
      end

      scenario 'Non-authenticated user tries to vote' do
        visit questions_path(question)

        expect(page).to have_content 'Rate: 0'
        expect(page).to_not have_content 'Reset'
        expect(page).to_not have_content 'Up'
        expect(page).to_not have_content 'Down'
      end

      scenario 'Authenticated author tries to vote' do
        sign_in(question.user)
        visit questions_path

        expect(page).to have_content 'Rate: 0'
        expect(page).to_not have_content 'Reset'
        expect(page).to_not have_content 'Up'
        expect(page).to_not have_content 'Down'
      end
    end
