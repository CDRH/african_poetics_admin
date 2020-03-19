class CreateNewsItemTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :news_item_types do |t|
      t.string :name
      t.timestamps
    end

    add_reference :news_items, :news_item_type
  end
end
