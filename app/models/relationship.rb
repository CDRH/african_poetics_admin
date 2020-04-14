class Relationship < ApplicationRecord
  belongs_to :subject, class_name: "Person"
  belongs_to :relationship_type
  belongs_to :object, class_name: "Person"

  def name
    # App crashes without this because RailsAdmin wants to call the primary key
    # "name" from the relationship_type table on the object due to tricky assocs
    # Return object Person's name,
    # except bbject isn't present for new Relationship form so return nil then
    object.present? ? object.name : nil
  end

  rails_admin do
    list do
      field :subject
      field :relationship_type do
        pretty_value do
          "#{value.name} to"
        end
      end
      field :object
      exclude_fields :created_at, :updated_at
    end
    edit do
      field :subject
      field :relationship_type do
        pretty_value do
          "#{value.name} to"
        end
      end
      field :object
      exclude_fields :created_at, :updated_at
    end
  end
end
