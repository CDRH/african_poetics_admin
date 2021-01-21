class NewsItemRole < ApplicationRecord

  belongs_to :news_item
  belongs_to :person
  belongs_to :role

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
