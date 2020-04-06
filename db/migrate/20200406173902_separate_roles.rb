class SeparateRoles < ActiveRecord::Migration[6.0]
  def change

    remove_column :news_item_roles, :role, :string
    remove_column :work_roles, :role, :string

    create_table :roles do |t|
      t.string :name
      t.string :description

      t.timestamps
    end

    add_reference :news_item_roles, :role
    add_reference :work_roles, :role

  end
end
