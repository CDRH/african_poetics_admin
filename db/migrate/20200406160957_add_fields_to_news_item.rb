class AddFieldsToNewsItem < ActiveRecord::Migration[6.0]
  def change

    add_column :news_items, :source_page_no, :string
    add_column :news_items, :source_link, :text
    add_column :news_items, :source_access_date,
      :datetime

    remove_column :news_items, :citation, :text

  end
end
