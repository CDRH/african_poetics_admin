class Commentary < ApplicationRecord

  has_and_belongs_to_many :commentary_authors,
    dependent: :destroy
  has_and_belongs_to_many :events,
    dependent: :destroy
  has_and_belongs_to_many :news_items,
    dependent: :destroy
  has_and_belongs_to_many :people,
    dependent: :destroy
  has_and_belongs_to_many :works,
    dependent: :destroy

end
