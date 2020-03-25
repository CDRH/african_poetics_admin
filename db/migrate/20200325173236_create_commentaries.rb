class CreateCommentaries < ActiveRecord::Migration[6.0]
  def change
    create_table :commentaries do |t|
      t.string :name
      t.text :content

      t.timestamps
    end

    create_join_table :commentaries, :events
    create_join_table :commentaries, :news_items
    create_join_table :commentaries, :people
    create_join_table :commentaries, :works
  end
end
