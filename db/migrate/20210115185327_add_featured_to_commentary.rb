class AddFeaturedToCommentary < ActiveRecord::Migration[6.0]
  def change
    add_column :commentaries, :featured, :boolean, default: false
  end
end
