class WorkRole < ApplicationRecord

  belongs_to :person
  belongs_to :work

  def name
    if person
      "#{person.name} (#{role})"
    end
  end

  rails_admin do
    list do
      configure :created_at do
        hide
      end
      configure :updated_at do
        hide
      end
    end
  end

end
