class Commentary < ApplicationRecord

  has_and_belongs_to_many :commentary_authors,
    dependent: :destroy
  has_and_belongs_to_many :events,
    dependent: :destroy
  has_and_belongs_to_many :news_items,
    dependent: :destroy
  has_and_belongs_to_many :people,
    dependent: :destroy
  has_and_belongs_to_many :works,
    dependent: :destroy

  rails_admin do
    list do
      configure :content do
        pretty_value do
          value ? "#{value[0..150]}..." : "[No content]"
        end
      end

      configure :created_at do
        hide
      end
      configure :updated_at do
        hide
      end
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
