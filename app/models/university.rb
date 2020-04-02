class University < ApplicationRecord

  belongs_to :location
  has_many :educations, dependent: :destroy

  rails_admin do
    list do

      configure :educations do
        hide
      end

      configure :created_at do
        hide
      end
      configure :updated_at do
        hide
      end
    end
  end

end
