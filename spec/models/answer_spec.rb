require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should validate_presence_of :body }
  it { should belong_to(:question) }
  it { should belong_to(:user) }
  it { should have_db_index(:question_id) }
  it { should have_db_index(:user_id) }
end
