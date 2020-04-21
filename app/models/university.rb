class University < ApplicationRecord

  belongs_to :location
  has_many :educations, dependent: :destroy

  validates :name, presence: true

  rails_admin do
    list do
      sort_by :name

      configure :name do
        search_operator "starts_with"
      end

      exclude_fields :created_at, :educations, :id, :updated_at
    end

    edit do
      exclude_fields :educations
    end
  end

end
