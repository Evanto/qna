module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :votable, dependent: :destroy
  end

  def rating
    votes.sum(:value)
  end

  def has_vote_by?(user)
    self.votes.exists?(user_id: user.id)
  end
end
