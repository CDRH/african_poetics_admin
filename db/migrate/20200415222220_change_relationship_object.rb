class ChangeRelationshipObject < ActiveRecord::Migration[6.0]
  def change
    change_table :relationships do |t|
      t.rename :object_id, :rel_object_id
    end
  end
end
