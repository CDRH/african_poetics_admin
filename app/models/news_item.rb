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
      field :people do
        label "Associated people (add before roles)"
        help "Optional. Add people, save, THEN add people roles"
      end
      field :news_item_roles do
        label "Associated people by role (add after associated people)"
        help "Optional. Add people, save, THEN add role to this field"
      end
      include_all_fields
    end
  end
end
