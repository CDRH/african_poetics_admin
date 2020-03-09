class University < ApplicationRecord

  belongs_to :location
  has_many :educations

end
