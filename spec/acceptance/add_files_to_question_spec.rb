require_relative 'acceptance_helper'

feature 'Add files to question', %q{
  In order to illustrate my question
  As a question author
  I'd like to attach files
  while creating a question
} do

  given(:user) { create(:user) }

  background do
    sign_in(user)
    visit new_question_path
  end

  scenario 'User adds file while creating a question' do
    fill_in 'Title', with: 'Test title'
    fill_in 'Body', with: 'test body'
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Create'

    expect(page).to have_content 'spec_helper.rb  '
  end
end
