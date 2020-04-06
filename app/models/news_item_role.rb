class NewsItemRole < ApplicationRecord

  belongs_to :news_item
  belongs_to :person
  belongs_to :role

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
