class CreatePeople < ActiveRecord::Migration[6.0]
  def change
    create_table :people do |t|
      t.string :poet_id
      t.string :name_last
      t.string :name_given
      t.string :name_alt
      t.string :gender
      t.string :date_birth
      t.string :date_death
      t.boolean :cap
      t.text :bibliography
      t.text :short_biography
      t.text :notes
      t.text :citations
      t.timestamps
    end
  end
end
