class CommentaryAuthor < ApplicationRecord

  has_and_belongs_to_many :commentaries

  validates :name_last, presence: true

  def name
    [ name_title, name_given, name_last ].compact.join(" ")
  end

  rails_admin do
    list do
      sort_by :name_last

      exclude_fields :created_at, :updated_at,
                     :commentaries, :id
    end

    edit do
      exclude_fields :commentaries
    end
  end

end
