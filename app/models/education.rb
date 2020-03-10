class Education < ApplicationRecord
  belongs_to :person
  belongs_to :university

  def name
    "#{person_name}, #{uni_name} (#{degree})"
  end

  def person_name
    person.name
  end

  def uni_name
    university.name
  end

  rails_admin do
    list do
      field :person_name
      field :uni_name
      field :year_started
      field :year_ended
      field :graduated
      field :degree
    end
   end

end
