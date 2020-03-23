class Publisher < ApplicationRecord

  belongs_to :location, optional: true
  has_many :news_items
  has_many :works

end
