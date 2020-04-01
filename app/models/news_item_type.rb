class NewsItemType < ApplicationRecord

  has_many :news_items

  rails_admin do
    list do
      configure :created_at do
        hide
      end
      configure :updated_at do
        hide
      end
    end
  end

end
