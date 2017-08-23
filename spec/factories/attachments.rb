FactoryGirl.define do
  factory :attachment do
    file Rack::Test::UploadedFile.new(File.open("#{Rails.root}/spec/rails_helper.rb"))
  end
end
