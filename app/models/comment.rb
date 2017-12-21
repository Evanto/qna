class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true, optional: true

  validates :body, presence: true
  
  default_scope { order(created_at: :asc) }
end
