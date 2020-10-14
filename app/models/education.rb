class Education < ApplicationRecord
  belongs_to :person
  belongs_to :university

  def name
    if person && university
      "#{person_name}, #{university_name} (#{degree})"
    end
  end

  def person_name
    person.name
  end

  def university_name
    university.name
  end

  rails_admin do
    list do
      items_per_page 25

      field :person_name
      field :university_name
      field :year_ended
      field :graduated
      field :degree
      field :complete
    end

    show do
      field :person
      field :university
      field :year_ended
      field :graduated
      field :degree
      field :complete
    end

    edit do
      field :person
      field :university
      field :year_ended
      field :graduated
      field :degree
      field :complete
    end
   end

end
