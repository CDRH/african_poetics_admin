class AddNewsItemContentType < ActiveRecord::Migration[6.0]
  def change
    create_table :news_item_content_types do |t|
      t.string :name
      t.timestamps
    end

    add_reference :news_items, :news_item_content_type
  end
end
