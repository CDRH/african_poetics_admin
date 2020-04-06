class RemovePoetId < ActiveRecord::Migration[6.0]
  def change
    remove_column :people, :poet_id, :string
  end
end
