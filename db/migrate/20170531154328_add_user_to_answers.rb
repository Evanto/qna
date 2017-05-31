class AddUserToAnswers < ActiveRecord::Migration[5.1]
  def change
    add_reference :answers, :user, foreign_key: true
  end
end
