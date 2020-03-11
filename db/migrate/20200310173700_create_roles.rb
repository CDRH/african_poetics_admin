class CreateRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :roles do |t|
      t.belongs_to :person
      t.belongs_to :news_item
      t.string :role

      t.timestamps
    end
  end
end
