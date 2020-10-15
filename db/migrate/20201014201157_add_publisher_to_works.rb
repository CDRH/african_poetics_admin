class AddPublisherToWorks < ActiveRecord::Migration[6.0]
  def change

    create_table :publishers do |t|
      t.string :name
      t.timestamps
    end

    add_reference :publishers, :location
    add_reference :works, :publisher

  end
end
