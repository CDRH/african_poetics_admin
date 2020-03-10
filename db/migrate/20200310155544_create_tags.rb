class CreateTags < ActiveRecord::Migration[6.0]
  def change
    create_table :tags do |t|
      t.string :name

      t.timestamps
    end

    create_join_table :tags, :news_items
  end
end
