class Role < ApplicationRecord

  has_many :news_item_roles
  has_many :work_roles

  validates :name, presence: true

  rails_admin do
    list do
      sort_by :name

      exclude_fields :created_at, :updated_at
      exclude_fields :news_item_roles, :work_roles
    end

    edit do
      exclude_fields :news_item_roles, :work_roles
    end
  end
end
