class Region < ApplicationRecord

  has_many :locations

  rails_admin do
    list do
      configure :created_at do
        hide
      end
      configure :updated_at do
        hide
      end
    end
  end

end
