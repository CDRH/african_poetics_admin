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

  def name
    pub = publisher ? publisher.name : ""
    "'#{article_title}', #{pub} (#{year})"
  end

  rails_admin do
    list do
      sort_by :article_title

      field :article_title
      field :news_item_type
      field :date do
        formatted_value do
          value.strftime("%Y-%m-%d")
        end
      end
      field :publisher
      field :news_item_roles do
        label "People by Role"
      end
    end
    show do
      configure :date do
        formatted_value do
          value.strftime("%Y-%m-%d")
        end
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
      field :news_item_type
      field :date
      field :publisher
      field :source_page_no
      field :source_link
      field :source_access_date
      field :repositories
      field :news_item_roles do
        label "People by Role (SEE HELP TEXT)"
        help <<-TEXT
          ATTENTION! Add people (below) to this news item first and hit 'Save and
          Edit.' Then double click a person's name in Role to assign."
        TEXT
      end
      field :people do
        label "All Associated People (add here first, then add role)"
      end
      field :events
      field :works
      field :excerpt
      field :tags
      field :notes
    end
  end
end
