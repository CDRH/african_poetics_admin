class NewsItem < ApplicationRecord
  include Dates

  belongs_to :news_item_type
  belongs_to :publisher

  has_and_belongs_to_many :commentaries
  has_and_belongs_to_many :events
  has_and_belongs_to_many :repositories
  has_and_belongs_to_many :tags
  has_and_belongs_to_many :works

  has_many :news_item_roles, dependent: :destroy
  has_many :people, through: :news_item_roles

  validates :article_title, presence: true

  def name
    pub = publisher ? publisher.name : ""
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
      field :date do
        formatted_value do
          value.strftime("%Y-%m-%d")
        end
      end
      field :publisher do
        label "Publication"
      end
      field :complete
    end

    show do
      configure :date do
        formatted_value do
          value.strftime("%Y-%m-%d")
        end
      end
      configure :news_item_type do
        label "Document Type"
      end
      configure :publisher do
        label "Publication"
      end
      configure :repositories do
        label "Archive"
      end
      configure :source_link do
        formatted_value do
          bindings[:view].link_to(value, value)
        end
      end
      configure :source_access_date do
        formatted_value do
          value.strftime("%Y-%m-%d")
        end
      end
    end

    edit do
      field :article_title
      field :news_item_type do
        label "Document Type"
      end
      field :date
      field :publisher do
        label "Publication"
      end
      field :source_page_no
      field :source_link
      field :source_access_date
      field :repositories do
        label "Archive"
      end
      include_all_fields
      exclude_fields :people, :news_item_roles
    end
  end
end
