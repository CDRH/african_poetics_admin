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
      items_per_page 150
      sort_by :title

      configure :title do
        search_operator "starts_with"
      end

      exclude_fields :created_at, :updated_at,
                     :citation, :commentaries, :id, :news_items, :people,
                     :work_roles
    end

    show do
      field :title
      field :people
      field :work_roles
      field :year
      field :publisher
      field :work_type
      field :citation
      field :commentaries
      field :news_items
    end

    edit do
      field :title
      field :people
      field :work_roles
      field :year do
        help "Required. YYYY, use 0 if unknown"
      end
      field :publisher
      field :work_type
      field :citation do
        help "This field added because works were imported from nonstandard formats and may require additional information"
      end
      field :commentaries

      include_all_fields
      # NOTE: Lorna said that works will always
      # be entered from a person page or news item
      # not from this interface, so hide news_items
      exclude_fields :news_items
    end
  end


end
