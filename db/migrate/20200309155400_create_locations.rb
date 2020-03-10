class CreateLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :locations do |t|
      t.string :city
      t.string :country
      t.string :region
      t.string :latlng
      t.timestamps
    end

    # join locations to people for "nationality"
    create_join_table :people, :locations
  end
end
