class CommentaryAuthor < ApplicationRecord

  has_and_belongs_to_many :commentaries,
    dependent: :destroy

end
