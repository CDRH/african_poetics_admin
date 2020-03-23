class WorkRole < ApplicationRecord

  belongs_to :person
  belongs_to :work

  def name
    if person
      "#{person.name} (#{role})"
    end
  end

end
