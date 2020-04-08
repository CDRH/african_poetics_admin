class University < ApplicationRecord

  belongs_to :location
  has_many :educations, dependent: :destroy

  rails_admin do
    list do
      sort_by :name

      configure :name do
        search_operator "starts_with"
      end
      configure :educations do
        hide
      end

      exclude_fields :created_at, :updated_at
    end
  end

end
