class CommentaryAuthor < ApplicationRecord

  has_and_belongs_to_many :commentaries,
    dependent: :destroy

  def name
    [ name_title, name_given, name_last ].compact.join(" ")
  end

end
