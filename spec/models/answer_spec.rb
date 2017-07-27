require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should validate_presence_of :body }
  it { should belong_to(:question) }
  it { should belong_to(:user) }
  it { should have_db_index(:question_id) }
  it { should have_db_index(:user_id) }
end

describe 'set answer to best:true' do
  let!(:question) { create(:question) }
  let!(:answer1)  { create(:answer, question: question, best: false) }
  let!(:answer2)  { create(:answer, question: question, best: true) }

  it 'sets answer 1 as best' do
    answer1.set_best
    expect(answer1.best).to eq true
  end

  it 'sets other answers to best:false' do
    answer2.set_best
    answer2.reload
    expect(answer2.best).to eq false
  end

  it 'should make the best answer first' do
    expect(question.answers.first.id).to eq answer2.id
  end
end
