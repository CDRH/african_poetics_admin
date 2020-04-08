class CommentaryAuthor < ApplicationRecord

  has_and_belongs_to_many :commentaries

  def name
    [ name_title, name_given, name_last ].compact.join(" ")
  end

  rails_admin do
    list do
      sort_by :name_last

      exclude_fields :created_at, :updated_at
    end
  end

end
