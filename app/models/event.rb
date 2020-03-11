class Event < ApplicationRecord

  has_many :event_roles
  has_many :people, through: :event_roles

  has_and_belongs_to_many :news_items,
    dependent: :destroy

  belongs_to :location

end
