require 'rails_helper'

RSpec.describe Vote, type: :model do
  it { should belong_to(:votable) }
  it { should belong_to(:user) }

  describe '#show_value' do
    let!(:question) { create(:question) }
    let!(:user) { create(:user) }
    let!(:vote) { question.votes.create(user: user, value: 1) }
    it 'should return like' do
      expect(vote&.show_value).to eq :like
    end

    it 'should return dislike' do
      vote.update!(value: -1)
      expect(vote&.show_value).to eq :dislike
    end
  end
end