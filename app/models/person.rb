class Person < ApplicationRecord

  # optional because this information is only collected for
  # major african poets, not all the people in the db
  belongs_to :gender, optional: true

  # foreign keys
  has_many :educations, dependent: :destroy

  # join tables
  has_and_belongs_to_many :commentaries
  has_and_belongs_to_many :events
  # nationality
  has_and_belongs_to_many :locations

  # join tables with attributes
  has_many :news_item_roles, dependent: :destroy
  has_many :news_items, through: :news_item_roles

  has_many :relationship_objects, foreign_key: :object_id, class_name: "Relationship"
  has_many :subjects, through: :relationship_objects

  has_many :relationship_subjects, foreign_key: :subject_id, class_name: "Relationship"
  has_many :objects, through: :relationship_subjects

  has_many :work_roles, dependent: :destroy
  has_many :works, through: :work_roles

#  validates :date_birth, format: {
#    with: /\A[12]\d{3}(\-(?:0[1-9]|1[0-2])\-(?:0[1-9]|[1-2]a[0-9]|3[01]))?\z/,
#    message: "YYYY-MM-DD or YYYY allowed"
#  }
#  validates :date_death, format: {
#    with: /\A[12]\d{3}(\-(?:0[1-9]|1[0-2])\-(?:0[1-9]|[1-2][0-9]|3[01]))?\z/,
#    message: "YYYY-MM-DD or YYYY allowed"
#  }
  validates :name_last, presence: true

  def name
    str = [ name_last, name_given ].compact.join(", ")
    str += " [#{name_alt}]" if name_alt
    str
  end

  rails_admin do
    list do
      sort_by :name_last

      configure :name_last do
        search_operator "starts_with"
      end
      configure :name_given do
        search_operator "starts_with"
      end
      configure :name_alt do
        search_operator "starts_with"
      end
      configure :date_birth do
        queryable false
      end
      configure :date_death do
        queryable false
      end

      field :name_last
      field :name_given
      field :name_alt
      field :major_african_poet
      field :complete
    end

    show do
      configure :locations do
        label "Nationality"
      end
      configure :objects do
        label "Relationship Objects"
        pretty_value do
          value.map { |person|
            relations = person.relationship_objects
              .where(subject_id: bindings[:object].id)
              .map { |r|
                "#{r.relationship_type.name}"
              }
              .uniq.join(", ")
            "#{relations} to #{person.name}"
          }.uniq.join("; ")
        end
      end
      configure :news_item_roles do
        pretty_value do
          value.map { |v| v.role }.uniq.join(", ")
        end
      end
      configure :subjects do
        label "Relationship Subjects"
        pretty_value do
          value.map { |person|
            relations = person.relationship_subjects
              .where(object_id: bindings[:object].id)
              .map { |r|
                "#{r.relationship_type.name}"
              }
              .uniq.join(", ")
            "#{person.name} is #{relations}"
          }.uniq.join("; ")
        end
      end
      configure :work_roles do
        pretty_value do
          value.map { |v| v.role }.uniq.join(", ")
        end
      end
      exclude_fields :relationship_objects, :relationship_subjects
    end

    edit do
      field :name_last
      field :name_given
      field :name_alt
      field :major_african_poet
      field :complete

      field :date_birth do
        help "YYYY-MM-DD or YYYY. Leave blank if not known."
      end
      field :date_death do
        help "YYYY-MM-DD or YYYY. Leave blank if alive or not known."
      end
      field :gender
      field :locations do
        label "Nationality"
      end
      field :bibliography
      field :short_biography
      include_all_fields
      exclude_fields :educations, :events, :news_items, :news_item_roles,
                     :objects, :relationship_objects, :relationship_subjects,
                     :subjects, :works, :work_roles
    end
  end

end
