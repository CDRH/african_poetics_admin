class WorkRole < ApplicationRecord

  belongs_to :person
  belongs_to :role
  belongs_to :work

  def name
    if person && role
      "#{person.name} (#{role.name})"
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
