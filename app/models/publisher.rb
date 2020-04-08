class Publisher < ApplicationRecord

  belongs_to :location, optional: true
  has_many :news_items
  has_many :works

  rails_admin do
    list do
      sort_by :name

      exclude_fields :created_at, :updated_at
    end
  end

end
