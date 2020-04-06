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
      exclude_fields :created_at, :updated_at
    end
  end

end
