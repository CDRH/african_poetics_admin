class Role < ApplicationRecord

  has_many :news_item_roles
  has_many :work_roles

  rails_admin do
    list do
      configure :created_at do
        hide
      end
      configure :updated_at do
        hide
      end
      configure :news_item_roles do
        hide
      end
      configure :work_roles do
        hide
      end
    end
  end
end
