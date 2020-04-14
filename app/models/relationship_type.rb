class RelationshipType < ApplicationRecord
  has_many :relationships, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  rails_admin do
    list do
      exclude_fields :created_at, :updated_at,
                     :relationships
    end
    edit do
      exclude_fields :created_at, :updated_at,
                     :relationships
    end
  end
end
