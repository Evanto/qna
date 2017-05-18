class Answer < ApplicationRecord
   validates :body, presence: true

   belongs_to :question
end
