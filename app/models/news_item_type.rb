class NewsItemType < ApplicationRecord

  has_many :news_items

  rails_admin do
    list do
      sort_by :name

      exclude_fields :created_at, :updated_at
    end
  end

end
