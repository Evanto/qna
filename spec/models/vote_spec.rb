require 'rails_helper'

RSpec.describe Vote, type: :model do
  it { should belong_to :user }
  it { should belong_to :votable }

  it do
     subject.user = FactoryGirl.build(:user)
     is_expected.to validate_uniqueness_of(:user_id).scoped_to(:votable_id, :votable_type)
     # alidation of uniqueness of user_id in the given scope
  end

  it { should validate_inclusion_of(:votable_type).in_array(['Question', 'Answer']) } #validates inclusion
  it { should validate_inclusion_of(:value).in_array([1,-1]) } #validates inclusion
end
