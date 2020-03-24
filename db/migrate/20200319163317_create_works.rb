class CreateWorks < ActiveRecord::Migration[6.0]
  def change
    create_table :works do |t|
      t.string :title
      t.integer :year
      t.text :citation
      t.boolean :publication

      t.timestamps
    end

    create_join_table :works, :news_items
    add_reference :works, :publisher
  end
end
