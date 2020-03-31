class CreateRegions < ActiveRecord::Migration[6.0]
  def change
    change_table :locations do |t|
      t.remove :region
    end

    create_table :regions do |t|
      t.string :name

      t.timestamps
    end

    add_reference :locations, :region

  end
end
