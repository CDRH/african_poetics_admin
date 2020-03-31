class CreateEventTypes < ActiveRecord::Migration[6.0]
  def change
    change_table :events do |t|
      t.remove :event_type
    end

    create_table :event_types do |t|
      t.string :name

      t.timestamps
    end

    add_reference :events, :event_type

  end
end
