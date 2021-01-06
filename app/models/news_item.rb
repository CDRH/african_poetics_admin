class NewsItem < ApplicationRecord
  include Dates

  belongs_to :news_item_type
  belongs_to :news_item_content_type
  belongs_to :publication

  has_and_belongs_to_many :commentaries
  has_and_belongs_to_many :events
  has_and_belongs_to_many :repositories
  has_and_belongs_to_many :tags
  has_and_belongs_to_many :works

  has_many :news_item_roles, dependent: :destroy
  has_many :people, through: :news_item_roles

  validates :article_title, presence: true

  def authors
    news_item_roles.joins(:role).where(roles: { name: "Critic" })
  end

  def name
    pub = publication ? publication.name : ""
    "'#{article_title}', #{pub} (#{year})"
  end

  rails_admin do
    list do
      sort_by :article_title

      field :article_title do
        search_operator "starts_with"
      end
      field :news_item_type do
        label "Document Type"
      end
      field :news_item_content_type do
        label "Content Type"
      end
      field :date do
        formatted_value do
          value.strftime("%Y-%m-%d") if value
        end
      end
      field :publication
      field :complete
    end

    show do
      field :article_title
      field :news_item_type do
        label "Document Type"
      end
      field :news_item_content_type do
        label "Content Type"
      end
      field :date do
        strftime_format "%Y-%m-%d"
      end
      field :publication
      field :source_page_no
      configure :source_link do
        formatted_value do
          bindings[:view].link_to(value, value)
        end
      end
      field :source_access_date do
        strftime_format "%Y-%m-%d"
      end
      field :source_link
      field :source_access_date
      field :repositories do
        label "Archive"
      end
      field :excerpt
      field :works
      field :events
      field :commentaries
      field :tags
      field :notes
      field :permissions
      field :people
      field :news_item_roles
      field :complete
    end

    edit do
      field :article_title
      field :news_item_type do
        label "Document Type"
      end
      field :news_item_content_type do
        label "Content Type"
      end
      field :date do
        strftime_format "%Y-%m-%d"
      end
      field :publication
      field :source_page_no
      field :source_link
      field :source_access_date do
        strftime_format "%Y-%m-%d"
      end
      field :repositories do
        label "Archive"
      end
      field :excerpt
      field :works
      field :events
      field :commentaries
      field :tags
      field :notes
      field :permissions

      field :people do
        help ""
        label "*"
        partial "warning_and_new_person_link"
      end

      field :news_item_roles do
        # Pre-populates New NewsItem Role modal with existing NewsItem selected
        inverse_of :news_item
      end

      field :complete
    end
  end
end
