class ChangePublishersToPublications < ActiveRecord::Migration[6.0]
  def change

    rename_table :publishers, :publications

    rename_column :news_items, :publisher_id, :publication_id
    rename_index :news_items, :index_news_items_on_publisher_id, :index_news_items_on_publication_id

    rename_column :works, :publisher_id, :publication_id
    rename_index :works, :index_news_items_on_publisher_id, :index_works_on_publication_id

  end
end
