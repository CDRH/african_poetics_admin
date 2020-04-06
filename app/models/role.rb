class Role < ApplicationRecord

  has_many :news_item_roles
  has_many :work_roles

  rails_admin do
    list do
      exclude_fields :created_at, :updated_at
      exclude_fields :news_item_roles, :work_roles
    end
  end
end
