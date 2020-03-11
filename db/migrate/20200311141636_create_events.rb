class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :date
      t.string :event_type
      t.string :name_original

      t.timestamps
    end

    create_table :event_roles do |t|
      t.belongs_to :person
      t.belongs_to :event
      t.string :role

      t.timestamps
    end

    # join table with no attributes
    create_join_table :events, :news_items
    # an event has a location
    add_reference :events, :location
  end
end
