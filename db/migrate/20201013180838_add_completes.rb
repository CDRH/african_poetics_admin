class AddCompletes < ActiveRecord::Migration[6.0]
  def change
    change_table :works do |t|
      t.boolean :complete
    end

    change_table :educations do |t|
      t.boolean :complete
    end
  end
end
