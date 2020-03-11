class NewsItem < ApplicationRecord

  has_and_belongs_to_many :tags,
    dependent: :destroy
  has_many :roles
  has_many :people, through: :roles

  def name
    "'#{article_title}', #{date}"
  end

  rails_admin do
    show do
      field :article_title
      field :item_type
      field :date
      field :roles do
        label "People by Role"
      end
      field :citation
      field :excerpt
      field :tags
    end
    edit do
      configure :roles do
        label "People by Role"
        help <<-TEXT
          ATTENTION! Add people (below) to this news item first and hit 'Save and
          Edit.' Then double click a person's name in Role to assign."
        TEXT
      end
    end
  end
end
