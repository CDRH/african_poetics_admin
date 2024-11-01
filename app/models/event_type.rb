class EventType < ApplicationRecord

  has_many :events

  validates :name, presence: true

  rails_admin do
    list do
      sort_by :name

      exclude_fields :created_at, :updated_at,
                     :events, :id
    end

    edit do
      exclude_fields :events
    end
  end

end
