class RetireCitationFromWork < ActiveRecord::Migration[6.0]
  def change
    add_column :works, :page_no, :string
    add_column :works, :issue, :string
    add_column :works, :volume, :string
    add_column :works, :source_link, :text
  end
end
