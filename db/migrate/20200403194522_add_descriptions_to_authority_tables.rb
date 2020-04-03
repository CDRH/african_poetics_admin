class AddDescriptionsToAuthorityTables < ActiveRecord::Migration[6.0]
  def change

    change_table :event_types do |t|
      t.string :description
    end
    change_table :news_item_types do |t|
      t.string :description
    end
    change_table :regions do |t|
      t.string :description
    end
    change_table :tags do |t|
      t.string :description
    end
    change_table :work_types do |t|
      t.string :description
    end

  end
end
