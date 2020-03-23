class CreateWorkRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :work_roles do |t|
      t.belongs_to :person
      t.belongs_to :work
      t.string :role

      t.timestamps
    end
  end
end
