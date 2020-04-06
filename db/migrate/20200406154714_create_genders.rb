class CreateGenders < ActiveRecord::Migration[6.0]
  def change

    remove_column :people, :gender, :string

    create_table :genders do |t|
      t.string :name

      t.timestamps
    end

    add_reference :people, :gender
  end
end
