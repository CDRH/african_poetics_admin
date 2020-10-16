class LatitudeLongitudeLocation < ActiveRecord::Migration[6.0]
  def change

    # remove_column :locations, :latlng, :string

    change_table :locations do |t|
      t.decimal :latitude, scale: 7, precision: 10
      t.decimal :longitude, scale: 7, precision: 10
    end
  end
end
