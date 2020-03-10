class Person < ApplicationRecord

  has_many :educations, dependent: :destroy
  has_and_belongs_to_many :locations  # nationality

  def name
    str = [ name_last, name_given ].compact.join(", ")
    str += " (#{name_alt})" if name_alt
    str
  end


end
