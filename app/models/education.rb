class Education < ApplicationRecord
  belongs_to :person
  belongs_to :university

  def name
    "#{person.name}, #{university.name} #{year_ended}, #{degree}"
  end

end
