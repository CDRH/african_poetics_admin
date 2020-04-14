class CreateRelationships < ActiveRecord::Migration[6.0]
  def change
    create_table :relationships do |t|
      t.integer :subject_id, foreign_key: true
      t.integer :object_id, foreign_key: true

      t.timestamps
    end
  end
end
