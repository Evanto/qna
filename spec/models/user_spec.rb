require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:questions).dependent(:destroy) }
  it { should have_many(:answers).dependent(:destroy) }

  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

  describe 'author_of?' do
    let(:user) { create(:user) }
    let(:user2) { create(:user) }
    let(:question) { create(:question, user: user) }
    let(:answer) { create(:answer, user: user) }

    it 'should return true if user owns the question' do
      expect(user.author_of?(question)).to eq true
    end

    it 'should return false if user does not own the question'
      expect(user.author_of?(question)).to eq false
    end

    it 'should return true if user owns the answer' do
      expect(user.author_of?(answer)).to eq true
    end

    it 'should return false if user does not own the answer'
      expect(user.author_of?(answer)).to eq false
    end

  end
end
