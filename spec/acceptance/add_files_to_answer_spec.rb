require_relative 'acceptance_helper'

feature 'Add files to answer', %q{
  In order to illustrate my answer
  As an answer author
  I'd like to attach files
  while creating an answer
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  background do
    sign_in(user)
    visit question_path(question)
  end

  scenario 'User adds a file while answering a question', js: true do
    fill_in 'Answer', with: 'Test answer'
    within(:xpath, './/form[@class="new_answer"]/div[@class="attachments"]/div[@class="nested-fields"][1]') do
    attach_file 'File', "#{Rails.root}/spec/rails_helper.rb"
    end
    click_on 'Post your answer'

    expect(page).to have_link 'rails_helper.rb', href: '/uploads/attachment/file/1/rails_helper.rb'
  end
end
