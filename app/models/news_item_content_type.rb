class NewsItemContentType < ApplicationRecord

  has_many :news_items

  validates :name, presence: true

  rails_admin do
    list do
      sort_by :name

      exclude_fields :created_at, :updated_at,
                     :id, :news_items
    end

    edit do
      exclude_fields :news_items
    end
  end

end
