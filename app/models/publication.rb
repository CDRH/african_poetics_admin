class Publication < ApplicationRecord

  belongs_to :location, optional: true
  belongs_to :repository, optional: true
  has_many :news_items
  has_many :works

  validates :name, presence: true

  rails_admin do
    list do
      sort_by :name

      configure :repository do
        label "Archive"
      end

      exclude_fields :created_at, :updated_at,
                     :id, :news_items, :works
    end

    show do
      configure :repository do
        label "Archive"
      end
    end

    edit do
      configure :repository do
        label "Archive"
      end

      exclude_fields :news_items, :works
    end
  end

end
