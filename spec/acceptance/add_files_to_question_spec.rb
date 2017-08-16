require_relative 'acceptance_helper'

feature 'Add files to question', %q{
  In order to illustrate my question
  As a question author
  I want to attach files
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
    #click_on 'Browse...'
    within(:xpath, './/form[@class="new_question"]/div[@class="attachments"]/div[@class="nested-fields"][1]') do
attach_file 'File', "#{Rails.root}/spec/rails_helper.rb"
    end

    click_on 'Create'

    expect(page).to have_link 'rails_helper.rb', href: '/uploads/attachment/file/1/rails_helper.rb'
  end
end
