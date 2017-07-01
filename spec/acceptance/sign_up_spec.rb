require_relative 'acceptance_helper'

feature 'New User can sign up on the website', %q{
  In order to ask questions,
  I want to be able to sign up
} do

  scenario 'Non-registered user signs up' do
    visit new_user_registration_path
    fill_in 'Email', with: 'user@domain.com'
    fill_in 'Password', with: '123123'
    fill_in 'Password confirmation', with: '123123'
    click_button 'Sign up'

    expect(page).to have_content 'Welcome! You have signed up successfully.'
    expect(current_path).to eq root_path
  end
end
