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
      exclude_fields :created_at, :updated_at
    end
  end

end
