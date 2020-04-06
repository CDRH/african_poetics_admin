class Work < ApplicationRecord

  belongs_to :publisher, optional: true
  belongs_to :work_type, optional: true

  has_many :work_roles, dependent: :destroy
  has_many :people, through: :work_roles

  has_and_belongs_to_many :commentaries
  has_and_belongs_to_many :news_items

  validates :title, presence: true
  validates :year, presence: true

  rails_admin do
    list do
      sort_by :title
      field :title
      field :year
      field :publisher
      field :work_type
      field :work_roles
    end
    edit do
      configure :news_items do
        hide
      end
      configure :year do
        help "Required. YYYY, use 0 if unknown"
      end
    end
  end


end
