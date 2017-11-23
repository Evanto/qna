class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.references :user, foreign_key: true
      t.text :body, null:false
      t.references :commentable, polymorphic: true, index: true

      t.timestamps
    end
      add_index :comments, [:commentable_id, :commentable_type]
  end
end
