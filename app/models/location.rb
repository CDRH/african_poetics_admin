class Location < ApplicationRecord

  belongs_to :region

  # country of nationality
  has_and_belongs_to_many :people
  has_many :events
  has_many :universities

  def name
    [ country, city, place ].compact.join(", ")
  end

  rails_admin do
    list do
      sort_by :country

      field :place
      field :local_place do
        label "Local Place Name"
      end
      field :city
      field :county_township do
        label "County / Township"
      end
      field :state_province_territory do
        label "State / Province / Territory"
      end
      field :country do
        search_operator "starts_with"
      end
      field :latitude
      field :longitude
      field :region

      exclude_fields :created_at, :updated_at,
                     :events, :id, :people, :universities
    end

    edit do
      field :place
      field :local_place do
        label "Local Place Name"
      end
      field :city
      field :county_township do
        label "County / Township"
      end
      field :state_province_territory do
        label "State / Province / Territory"
      end
      field :country do
        search_operator "starts_with"
      end
      field :latitude do
        help 'Use decimal degrees, e.g. "-5.28910" up to 7 decimal places'
      end
      field :longitude do
        help 'Use decimal degrees, e.g. "-5.28910" up to 7 decimal places'
      end
      field :region

      exclude_fields :events, :people, :universities
    end
  end

end
