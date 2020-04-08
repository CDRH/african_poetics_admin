class Gender < ApplicationRecord

  has_many :people

  rails_admin do
    list do
      sort_by :name

      exclude_fields :created_at, :updated_at
    end
  end

end
