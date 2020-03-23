class Event < ApplicationRecord
  include Dates

  before_save :set_date_not_before

  has_and_belongs_to_many :news_items,
    dependent: :destroy
  has_and_belongs_to_many :people,
    dependent: :destroy

  belongs_to :location, optional: true

  rails_admin do
    edit do
      field :name
      field :date
      field :event_type
      field :location
      field :news_items
      field :people
    end
  end

end