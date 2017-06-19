require 'rails_helper'

feature 'Authenticated User logs out', %q{
  In order to quit,
  I want to be able to sign out of an app
} do

  given(:user) { create(:user) }

  scenario 'Authenticated user logs out' do
    sign_in(user)  # we need a logged in user to test loggin off
    visit root_path
    click_on 'Sign out'

    expect(page).to have_content 'Signed out successfully'
    expect(current_path).to eq root_path
  end

  scenario 'Non-authenticated user logs out' do
    visit root_path
    expect(page).to_not have_content 'Sign out'
  end
end
