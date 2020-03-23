class Work < ApplicationRecord

  belongs_to :publisher
  belongs_to :work

  has_many :work_roles, dependent: :destroy
  has_many :people, through: :work_roles

  has_and_belongs_to_many :news_item,
    dependent: :destroy
end
