class Relationship < ApplicationRecord
  belongs_to :subject, class_name: "Person"
  belongs_to :relationship_type
  belongs_to :rel_object, class_name: "Person"

  def name
    # App crashes without this because RailsAdmin wants to call the primary key
    # "name" from the relationship_type table on the object due to tricky assocs
    # Return object Person's name,
    # except bbject isn't present for new Relationship form so return nil then
    rel_object.present? ? rel_object.name : nil
  end

  rails_admin do
    list do
      field :subject
      field :relationship_type do
        pretty_value do
          "#{value.name} to"
        end
      end
      field :rel_object do
        label "Object"
      end
      exclude_fields :created_at, :updated_at
    end
    show do
      configure :rel_object do
        label "Object"
      end
    end
    edit do
      field :subject
      field :relationship_type do
        pretty_value do
          "#{value.name} to"
        end
      end
      field :rel_object do
        label "Object"
      end
      exclude_fields :created_at, :updated_at
    end
  end
end
