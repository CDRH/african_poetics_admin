class Location < ApplicationRecord

  has_and_belongs_to_many :people  # nationality
  has_many :universities

  def name
    [ region, country, city ].compact.join(", ")
  end

end
