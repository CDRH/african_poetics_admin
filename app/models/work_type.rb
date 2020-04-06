class WorkType < ApplicationRecord

  has_many :works

  rails_admin do
    list do
      exclude_fields :created_at, :updated_at
    end
  end

end
