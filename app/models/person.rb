class Person < ApplicationRecord

  has_many :educations, dependent: :destroy
  has_and_belongs_to_many :locations,
    dependent: :destroy  # nationality
  has_many :roles
  has_many :news_items, through: :roles

  def name
    str = [ name_last, name_given ].compact.join(", ")
    str += " [#{name_alt}]" if name_alt
    str
  end

  rails_admin do
    list do
      field :name
      field :name_last
      field :gender
      field :date_birth
      field :date_death
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
      configure :roles do
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
