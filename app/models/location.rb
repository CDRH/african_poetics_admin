class Location < ApplicationRecord

  belongs_to :region

  # nationality
  has_and_belongs_to_many :people
  has_many :events
  has_many :universities

  def name
    [ country, city, place ].compact.join(", ")
  end

  rails_admin do
    list do
      sort_by :country

      configure :country do
        search_operator "starts_with"
      end

      exclude_fields :created_at, :updated_at,
                     :events, :people, :universities
    end
  end

end
