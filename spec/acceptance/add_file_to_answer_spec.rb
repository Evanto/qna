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

  scenario 'User adds a file while answering a question' do
    fill_in 'Answer', with: 'Test answer'
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Post your answer'

    within '.answers' do
      expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
    end
  end
end
