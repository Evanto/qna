require_relative 'acceptance_helper'

feature 'Edit question', %q{
  in order to change my existing question
  as question author I want to be able
  to edit my question
} do

  given!(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }

  scenario 'Guest tries to edit a question' do
    visit question_path(question)

    expect(page).to_not have_link 'Edit'
  end

  describe 'Authenticated user' do
    before do
      sign_in user
      visit question_path(question)
    end

    scenario 'Sees Edit link' do
      within '.questions' do
        expect(page).to have_link 'Edit'
      end
    end

    scenario 'Edits his question', js: true do
      click_on 'Edit'
      within '.questions' do
        fill_in 'Body', with: 'edited question'
        click_on 'Save'

        expect(page).to_not have_content question.body
        expect(page).to have_content 'edited question'
      end
    end
  end

    scenario "Authenticated user tries to edit other user's question" do
      user2 = create(:user)
      visit question_path(question)

      within '.questions' do
        expect(page).to_not have_link 'Edit'
    end
  end
end
