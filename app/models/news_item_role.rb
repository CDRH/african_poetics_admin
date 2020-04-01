class NewsItemRole < ApplicationRecord

  belongs_to :news_item
  belongs_to :person

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
