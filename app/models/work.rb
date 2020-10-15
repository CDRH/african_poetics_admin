class Work < ApplicationRecord

  belongs_to :location, optional: true
  belongs_to :publication, optional: true
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
      # do not exclude "complete"
      exclude_fields :created_at, :updated_at,
                     :citation, :commentaries, :id, :location, :news_items,
                     :people, :work_roles
    end

    show do
      field :title
      field :people
      field :work_roles
      field :work_type
      field :year
      field :publisher
      field :location
      field :page_no
      field :issue
      field :volume
      field :source_link
      field :commentaries
      field :news_items
      field :complete
    end

    edit do
      field :title
      field :work_type
      field :year do
        help "Required. YYYY, use 0 if unknown"
      end
      field :publisher
      field :location
      field :page_no
      field :issue
      field :volume
      field :source_link
      field :commentaries

      field :people do
        help ""
        label "*"
        partial "warning_and_new_person_link"
      end

      field :work_roles do
        # Pre-populates New Work Role modal with existing Work selected
        inverse_of :work
      end
      field :complete

      # NOTE: Lorna said that works will always
      # be entered from a person page or news item
      # not from this interface, so don't add news_items here
    end
  end


end
