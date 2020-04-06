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

      exclude_fields :created_at, :updated_at
      exclude_fields :citation, :commentaries,
        :news_items, :people
    end
    edit do
      field :title
      field :year do
        help "Required. YYYY, use 0 if unknown"
      end
      field :publisher
      field :work_type
      field :citation do
        help "This field added because works were imported from nonstandard formats and may require additional information"
      end
      field :people do
        label "Associated people (add before roles)"
        help "Optional. Add people, save, THEN add person roles"
      end
      field :work_roles do
        label "Person roles (add after people)"
        help "Optional. Add people, save, THEN add role to this field"
      end
      include_all_fields
      # NOTE: Lorna said that works will always
      # be entered from a person page or news item
      # not from this interface, so hide news_items
      exclude_fields :news_items
    end
  end


end
