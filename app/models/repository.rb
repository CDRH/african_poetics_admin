class Repository < ApplicationRecord

  belongs_to :location, optional: true
  has_and_belongs_to_many :news_items,
    dependent: :destroy

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
