class Publisher < ApplicationRecord

  belongs_to :location, optional: true
  has_many :works

  validates :name, presence: true

  rails_admin do
    list do
      sort_by :name

      exclude_fields :created_at, :updated_at,
                     :id, :works
    end

    show do
      exclude_fields :created_at, :updated_at
    end

    edit do
      exclude_fields :works
    end
  end

end
