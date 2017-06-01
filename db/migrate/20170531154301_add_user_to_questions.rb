class AddUserToQuestions < ActiveRecord::Migration[5.1]
  def change
    add_reference :questions, :user, foreign_key: true
  end
end
