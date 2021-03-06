class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  include Votable
#  include Commentable

  validates :title, :body, presence: true
  accepts_nested_attributes_for :attachments, reject_if: :all_blank, allow_destroy: true
end
