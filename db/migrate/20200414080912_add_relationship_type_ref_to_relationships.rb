class AddRelationshipTypeRefToRelationships < ActiveRecord::Migration[6.0]
  def change
    # Only works for mysql2 gem
    add_reference :relationships, :relationship_type, null: false, foreign_key: true

    # SQLite throws error: Cannot add a NOT NULL column with default value NULL
    # Solution is to set NOT NULL immediately after adding column
#    add_reference :relationships, :relationship_type, foreign_key: true
#    change_table :relationships do |t|
#      t.change :relationship_type_id, :integer, null: false
#    end
  end
end
