class Repository < ApplicationRecord

  belongs_to :location, optional: true
  has_and_belongs_to_many :news_items,
    dependent: :destroy

end
