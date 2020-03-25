class Work < ApplicationRecord

  belongs_to :publisher, optional: true
  belongs_to :work_type, optional: true

  has_many :work_roles, dependent: :destroy
  has_many :people, through: :work_roles

  has_and_belongs_to_many :news_items,
    dependent: :destroy

  rails_admin do
    list do
      sort_by :title
      field :title
      field :year
      field :publisher
      field :work_type
      field :work_roles
    end
  end


end
