class AddLocationToWork < ActiveRecord::Migration[6.0]
  def change
    add_reference :works, :location, foreign_key: true
  end
end
