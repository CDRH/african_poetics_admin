class AddLocationFields < ActiveRecord::Migration[6.0]
  def change
    change_table :locations do |t|
      t.string :local_place
      t.string :county_township
      t.string :state_province_territory
    end
  end
end
