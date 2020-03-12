class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :date
      t.string :event_type

      t.timestamps
    end

    create_join_table :events, :news_items
    create_join_table :events, :people
    add_reference :events, :location
  end
end
