class Commentary < ApplicationRecord

  has_many :metacommentary_objects, foreign_key: :meta_object_id, class_name: "MetaCommentary"
  has_many :subjects, through: :metacommentary_objects

  has_many :metacommentary_subjects, foreign_key: :subject_id, class_name: "MetaCommentary"
  has_many :meta_objects, through: :metacommentary_subjects

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

      field :name
      field :featured
      field :content
      field :commentary_authors
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
      configure :meta_objects do
        label "Mentions"
      end
      configure :subjects do
        label "Mentioned by"
      end

      exclude_fields :metacommentary_objects, :metacommentary_subjects
    end

    edit do
      field :name
      field :featured
      field :content
      field :commentary_authors
    end
  end

end
