require_relative 'acceptance_helper'
  feature 'User can vote for answers', %q{
    In order to express my opinion about
    other users answers I want to be able to
    upvote/downvote answers and reset my vote
    as an authenticated user
    } do

      given(:user) { create(:user) }
      given!(:answer) { create(:answer) }

      scenario 'An authenticated non-author of an answer votes for it', js: true do
        sign_in(user)
        visit question_path(answer.question)

        within '.answers' do

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
    end

    scenario 'Non-authenticated user tries to vote' do
      visit question_path(answer.question)

      within '.answers' do
        expect(page).to have_content 'Rate: 0'
        expect(page).to_not have_content 'Reset'
        expect(page).to_not have_content 'Up'
        expect(page).to_not have_content 'Down'
      end
    end

    scenario 'Authenticated author tries to vote' do
      sign_in(answer.user)
      visit question_path(answer.question)

      within '.answers' do
        expect(page).to have_content 'Rate: 0'
        expect(page).to_not have_content 'Reset'
        expect(page).to_not have_content 'Up'
        expect(page).to_not have_content 'Down'
      end
    end

  end
