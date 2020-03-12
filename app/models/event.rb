class Event < ApplicationRecord

  has_and_belongs_to_many :news_items,
    dependent: :destroy
  has_and_belongs_to_many :people,
    dependent: :destroy

  belongs_to :location

end
