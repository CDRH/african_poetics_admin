class Person < ApplicationRecord

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
      field :name_last
      field :name_given
      field :gender
      field :date_birth
      field :date_death
      field :complete
      field :cap
      field :poet_id
      field :locations do
        label "Nationality"
      end
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
      configure :locations do
        label "Nationality"
      end
    end
  end

end
