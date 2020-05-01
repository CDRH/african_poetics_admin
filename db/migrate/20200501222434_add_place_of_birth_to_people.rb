class AddPlaceOfBirthToPeople < ActiveRecord::Migration[6.0]
  def change
    add_reference(:people, :place_of_birth, foreign_key: {to_table: :locations})
  end
end
