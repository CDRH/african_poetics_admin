class CreatePublishers < ActiveRecord::Migration[6.0]
  def change
    create_table :publishers do |t|
      t.string :name

      t.timestamps
    end

    add_reference :publishers, :location
    add_reference :news_items, :publisher
  end
end
