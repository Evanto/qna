class AddBestToAnswers < ActiveRecord::Migration[5.1]
  def change
    add_column :answers, :best, :boolean, default: false, null: false
  end
end
