class CreateRepositories < ActiveRecord::Migration[6.0]
  def change
    create_table :repositories do |t|
      t.string :name

      t.timestamps
    end

    add_reference :repositories, :location
    create_join_table :repositories, :news_items
  end
end
