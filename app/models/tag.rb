class Tag < ApplicationRecord

  has_and_belongs_to_many :news_items

  validates :name, presence: true

  def item_number
    news_items.count
  end

  rails_admin do
    list do
      # Lowered from 50 due to item_number slowing page load
      items_per_page 25
      sort_by :name

      configure :name do
        search_operator "starts_with"
      end

      field :name
      field :item_number
      field :description
    end

    edit do
      exclude_fields :news_items
    end
  end

end
