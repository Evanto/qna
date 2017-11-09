module Commentable
  extend ActiveSupport::Concern

  included do
    has_many :comments, dependent: :destroy, as: :commentable
  end
end
