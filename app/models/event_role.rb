class EventRole < ApplicationRecord

  belongs_to :event
  belongs_to :person

  def name
    if person
      "#{person.name} (#{role})"
    end
  end

end
