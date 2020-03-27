class CreateCommentaryAuthors < ActiveRecord::Migration[6.0]
  def change
    create_table :commentary_authors do |t|
      t.string :name_last
      t.string :name_given
      t.string :name_title
      t.text :short_biography

      t.timestamps
    end

    create_join_table :commentaries, :commentary_authors

  end
end
