class Publisher < ApplicationRecord

  belongs_to :location, optional: true
  has_many :news_items
  has_many :works

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
