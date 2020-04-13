class WorkType < ApplicationRecord

  has_many :works

  validates :name, presence: true

  rails_admin do
    list do
      sort_by :name

      exclude_fields :created_at, :updated_at,
                     :works
    end
  end

end
