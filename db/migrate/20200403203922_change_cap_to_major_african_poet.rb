class ChangeCapToMajorAfricanPoet < ActiveRecord::Migration[6.0]
  def change

    remove_column :people, :cap, :boolean
    add_column :people, :major_african_poet, :boolean
  end
end
