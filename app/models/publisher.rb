class Publisher < ApplicationRecord

  belongs_to :location, optional: true
  has_many :news_items
  has_many :works

  validates :name, presence: true

  rails_admin do
    list do
      sort_by :name

      exclude_fields :created_at, :updated_at,
                     :news_items, :works
    end

    edit do
      exclude_fields :news_items, :works
    end
  end

end
