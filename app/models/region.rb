class Region < ApplicationRecord

  has_many :locations

  validates :name, presence: true

  rails_admin do
    list do
      sort_by :name

      exclude_fields :created_at, :updated_at,
                     :id, :locations
    end
  end

end
