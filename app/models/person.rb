class Person < ApplicationRecord

  has_many :educations, dependent: :destroy
  belongs_to :location

  def name
    str = ""
    str += name_last
    str += " #{name_given}" if name_given
    str += " (#{name_alt})" if name_alt
    str
  end


end
