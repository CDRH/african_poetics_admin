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

  has_many :work_roles, dependent: :destroy
  has_many :works, through: :work_roles

  def name
    str = [ name_last, name_given ].compact.join(", ")
    str += " [#{name_alt}]" if name_alt
    str
  end

  rails_admin do
    list do
      sort_by :name_last

      configure :locations do
        label "Nationality"
      end

      exclude_fields :created_at, :updated_at
      # exclude text fields
      exclude_fields :bibliography, :short_biography, :notes
      # exclude associations (except locations)
      exclude_fields :commentaries, :educations, :events,
        :news_item_roles, :news_items, :work_roles, :works
    end

    show do
      configure :locations do
        label "Nationality"
      end
      configure :news_item_roles do
        pretty_value do
          value.map { |v| v.role }.uniq.join(", ")
        end
      end
      configure :work_roles do
        pretty_value do
          value.map { |v| v.role }.uniq.join(", ")
        end
      end
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
      field :educations
      field :bibliography
      field :short_biography
      field :news_items do
        label "News items (add before roles)"
        help "Optional. Add news items, save, THEN add news item role"
      end
      field :news_item_roles do
        label "News item roles (add after news items)"
        help "Optional. First add a news item, save, THEN add roles to this field"
      end
      field :works do
        label "Works (add before roles)"
        help "Optional. Add works, save, THEN add work role"
      end
      field :work_roles do
        label "Work roles (add after works)"
        help "Optional. First add a news item, save, THEN add roles to this field"
      end
      # despite adding a few above here to work with the order,
      # go ahead and display everything
      include_all_fields
    end
  end

end
