class CreateEducationsAndUniversities < ActiveRecord::Migration[6.0]
  def change
    create_table :educations do |t|
      t.integer :year_ended
      t.boolean :graduated
      t.string :degree
      t.timestamps
    end

    create_table :universities do |t|
      t.string :name
      t.timestamps
    end

    add_reference :educations, :person
    add_reference :educations, :university
    add_reference :universities, :location
  end
end
