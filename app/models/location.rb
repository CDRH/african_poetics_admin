class Location < ApplicationRecord

  belongs_to :region

  # nationality
  has_and_belongs_to_many :people,
    dependent: :destroy
  has_many :events
  has_many :universities

  def name
    [ country, city, place ].compact.join(", ")
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
