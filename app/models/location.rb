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
                     :events, :id, :people, :universities
    end

    edit do
      configure :latlng do
        label "Latitude, Longitude"
        help 'Values must be in decimal degrees, e.g. "5.5911921, -0.3198155"'
      end

      exclude_fields :events, :people, :universities
    end
  end

end
