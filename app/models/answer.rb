class Answer < ApplicationRecord
  belongs_to :question

  validates :body, presence: true
end
