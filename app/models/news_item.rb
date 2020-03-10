class NewsItem < ApplicationRecord

  has_and_belongs_to_many :tags,
    dependent: :destroy

  def name
    "'#{article_title}', #{date}"
  end

end
