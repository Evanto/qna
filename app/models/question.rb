class Question < ApplicationRecord
    validates :title, :body, presence: true

    has_many :answers, dependent: :destroy
end
