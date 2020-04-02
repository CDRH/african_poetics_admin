class Tag < ApplicationRecord

  has_and_belongs_to_many :news_items

  def item_number
    news_items.count
  end

  rails_admin do
    list do
      field :name
      field :item_number
      field :news_items
    end
  end

end
