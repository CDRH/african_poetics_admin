class CreateMetaCommentaries < ActiveRecord::Migration[6.0]
  def change
    create_table :meta_commentaries do |t|
      t.integer :subject_id, foreign_key: true
      t.integer :meta_object_id, foreign_key: true

      t.timestamps
    end
  end
end
