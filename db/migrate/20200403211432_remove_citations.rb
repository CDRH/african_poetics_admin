class RemoveCitations < ActiveRecord::Migration[6.0]
  def change
    remove_column :people, :citations, :text
  end
end
