class CommentaryAuthor < ApplicationRecord

  has_and_belongs_to_many :commentaries

  def name
    [ name_title, name_given, name_last ].compact.join(" ")
  end

  rails_admin do
    list do
      configure :created_at do
        hide
      end
      configure :updated_at do
        hide
      end
    end
  end

end
