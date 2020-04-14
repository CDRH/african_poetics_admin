class Gender < ApplicationRecord

  has_many :people

  validates :name, presence: true

  rails_admin do
    list do
      sort_by :name

      exclude_fields :created_at, :updated_at,
                     :people
    end

    edit do
      exclude_fields :people
    end
  end

end
