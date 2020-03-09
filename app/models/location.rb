class Location < ApplicationRecord

  has_many :universities

  def name
    [ city, country, region ].compact.join(", ")
  end

end
