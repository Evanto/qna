class AddQuestionIdToAttachment < ActiveRecord::Migration[5.1]
  def change
    add_column :attachments, :question_id, :integer
    add_index :attachments, :question_id

    #add_column :attachments, :attachable_id, :integer
    #add_column :attachments, :attachable_type, :string

    #add_index :attachments, [:attachable_id, :attachable_type]
  end
end
