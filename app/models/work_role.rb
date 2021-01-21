class WorkRole < ApplicationRecord

  belongs_to :person
  belongs_to :role
  belongs_to :work

  def name
    name_parts = []
    name_parts << person.name if person
    if role
      name_parts << "(#{role.name})"
      name_parts << "- author" if author
    end
    name_parts.compact.join(" ")
  end

  rails_admin do
    list do
      exclude_fields :created_at, :id, :updated_at
    end
  end

end
