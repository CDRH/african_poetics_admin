class Repository < ApplicationRecord

  belongs_to :location, optional: true
  has_and_belongs_to_many :news_items

  validates :name, presence: true

  rails_admin do
    list do
      sort_by :name

      exclude_fields :created_at, :updated_at,
                     :locations, :news_items
    end
  end

end
