class Location < ApplicationRecord

  # nationality
  has_and_belongs_to_many :people,
    dependent: :destroy
  has_many :events
  has_many :universities

  def name
    [ region, country, city ].compact.join(", ")
  end

end
