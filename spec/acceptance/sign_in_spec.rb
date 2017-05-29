require 'rails_helper'

feature 'User sign in', %q{
  In order to be able to ask a question, a user should sign in
} do

  scenario 'A registered user attempts to sign in' do
    User.create!(email: 'user@test.com', password: '123123') # создали юзера из модели

    visit new_user_session_path # юзер идет на страницу логина
    fill_in 'Email', with: 'user@test.com'
    fill_in 'Password', with: '123123'
    # save_and_open_page # launchy
    click_on 'Log in'

    expect(page).to have_content 'Signed in successfully.'
    expect(current_path).to eq root_path
  end

  scenario 'A non-registered user attempts to sign in' do
    visit new_user_session_path # юзер идет на страницу логина
    fill_in 'Email', with: 'user@test.com'
    fill_in 'Password', with: '123'
    click_on 'Log in'

    expect(page).to have_content 'Invalid Email or password. Log in Email Password Remember me Sign up Forgot your password?'
    expect(current_path).to eq new_user_session_path
  end

end
1
