require_relative 'acceptance_helper'

feature 'Edit answer', %q{
  in order to change my existing answer
  as answer author I want to be able
  to edit my answer
} do

  given!(:user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer, question: question, user: user) }

  scenario 'Guest tries to edit an answer' do
    visit question_path(question)

    expect(page).to_not have_link 'Edit'
  end

  describe 'Authenticated user' do
    before do
      sign_in user
      visit question_path(question)
    end

    scenario 'Sees Edit link' do
      within '.answers' do
        expect(page).to have_link 'Edit'
      end
    end

    scenario 'Edits his answer', js: true do
      click_on 'Edit'
      within '.answers' do
        fill_in 'Answer', with: 'edited answer'
        click_on 'Save'

        expect(page).to_not have_content answer.body
        expect(page).to_not have_selector 'textarea'
        expect(page).to have_content 'edited answer'
      end
    end
  end

    scenario "Authenticated user tries to edit other user's answer" do
      user2 = create(:user)
      visit question_path(question)

      within '.answers' do
        expect(page).to_not have_link 'Edit'
    end
  end
end
