class NewsItem < ApplicationRecord
  include Dates

  belongs_to :news_item_type
  belongs_to :publisher

  has_and_belongs_to_many :events,
    dependent: :destroy
  has_and_belongs_to_many :repositories,
    dependent: :destroy
  has_and_belongs_to_many :tags,
    dependent: :destroy

  has_many :news_item_roles
  has_many :people, through: :news_item_roles

  def name
    "'#{article_title}', #{publisher.name} (#{year})"
  end

  rails_admin do
    show do
      field :article_title
      field :news_item_type
      field :date
      field :news_item_roles do
        label "People by Role"
      end
      field :citation
      field :excerpt
      field :tags
      field :events
    end
    edit do
      configure :news_item_roles do
        label "People by Role (SEE HELP TEXT)"
        help <<-TEXT
          ATTENTION! Add people (below) to this news item first and hit 'Save and
          Edit.' Then double click a person's name in Role to assign."
        TEXT
      end
    end
  end
end
