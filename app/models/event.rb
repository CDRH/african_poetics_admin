class Event < ApplicationRecord
  include Dates

  before_save :set_date_not_before

  has_and_belongs_to_many :commentaries
  has_and_belongs_to_many :news_items
  has_and_belongs_to_many :people

  belongs_to :event_type
  belongs_to :location, optional: true

  rails_admin do
    list do
      sort_by :name

      field :name
      field :date
      field :event_type
      field :location
      field :summary
    end
    edit do
      configure :date_not_before do
        hide
      end
    end
  end

end
