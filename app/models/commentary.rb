class Commentary < ApplicationRecord

  has_and_belongs_to_many :commentary_authors
  has_and_belongs_to_many :events
  has_and_belongs_to_many :news_items
  has_and_belongs_to_many :people
  has_and_belongs_to_many :works

  validates :name, presence: true

  rails_admin do
    list do
      sort_by :name

      configure :content do
        pretty_value do
          value ? "#{value[0..150]}..." : "[No content]"
        end
      end

      exclude_fields :created_at, :updated_at,
                     :events, :news_items, :people, :works
    end

    show do
      configure :content do
        formatted_value do
          if value
            bindings[:view].sanitize(value)
          else
            "[No content]"
          end
        end
      end
    end
  end

end
