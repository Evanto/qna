class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :votable, polymorphic: true, optional: true

  validates :user_id, uniqueness: { scope: [:votable_id, :votable_type] }
  validates :votable_type, inclusion: ['Question', 'Answer']
  validates :value, inclusion: { in: [1, -1] }
end
