class AddCompleteCheckbox < ActiveRecord::Migration[6.0]
  def change

    change_table :events do |t|
      t.boolean :complete
    end
    change_table :news_items do |t|
      t.boolean :complete
    end
    change_table :people do |t|
      t.boolean :complete
    end
  end
end
