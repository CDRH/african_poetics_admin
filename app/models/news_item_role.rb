class NewsItemRole < ApplicationRecord

  belongs_to :news_item
  belongs_to :person

  def name
    if person
      "#{person.name} (#{role})"
    end
  end

end
