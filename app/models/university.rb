class University < ApplicationRecord

  belongs_to :location
  has_many :educations, dependent: :destroy

  rails_admin do
    list do

      configure :educations do
        hide
      end

      exclude_fields :created_at, :updated_at
    end
  end

end
