class AddPermissionsToNewsItems < ActiveRecord::Migration[6.0]
  def change
    change_table :news_items do |t|
      t.text :permissions
    end
  end
end
