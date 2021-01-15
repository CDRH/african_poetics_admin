class AddAuthorToRoles < ActiveRecord::Migration[6.0]
  def change
    add_column :news_item_roles, :author, :boolean, default: false
    add_column :work_roles, :author, :boolean, default: false
  end
end
