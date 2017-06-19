module AcceptanceHelper
  def sign_in(user)
    visit new_user_session_path # юзер идет на страницу логина
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
  end
end
