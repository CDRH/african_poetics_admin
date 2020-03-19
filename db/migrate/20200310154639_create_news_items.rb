class CreateNewsItems < ActiveRecord::Migration[6.0]
  def change
    create_table :news_items do |t|
      t.string :article_title
      t.datetime :date
      t.text :citation
      t.text :excerpt
      t.text :notes

      t.timestamps
    end
  end
end
