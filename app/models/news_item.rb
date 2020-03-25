class NewsItem < ApplicationRecord
  include Dates

  belongs_to :news_item_type
  belongs_to :publisher

  has_and_belongs_to_many :commentaries,
    dependent: :destroy
  has_and_belongs_to_many :events,
    dependent: :destroy
  has_and_belongs_to_many :repositories,
    dependent: :destroy
  has_and_belongs_to_many :tags,
    dependent: :destroy
  has_and_belongs_to_many :works,
    dependent: :destroy

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
      field :citation
      field :news_item_roles do
        label "People by Role"
      end
    end
    show do
      field :article_title
      field :news_item_type
      field :date
      field :publisher
      field :citation
      field :repositories
      field :news_item_roles do
        label "People by Role (SEE HELP TEXT)"
      end
      field :people
      field :events
      field :works
      field :excerpt
      field :tags
      field :notes
    end
    edit do
      field :article_title
      field :news_item_type
      field :date
      field :publisher
      field :citation
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
