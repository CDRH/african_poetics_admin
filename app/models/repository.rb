class Repository < ApplicationRecord

  belongs_to :location, optional: true
  has_and_belongs_to_many :news_items

  rails_admin do
    list do
      exclude_fields :created_at, :updated_at
    end
  end

end
