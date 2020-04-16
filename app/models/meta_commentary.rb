class MetaCommentary < ApplicationRecord
  belongs_to :subject, class_name: "Commentary"
  belongs_to :meta_object, class_name: "Commentary"

  rails_admin do
    list do
      field :subject
      field :meta_object do
        label "Object"
      end
      exclude_fields :created_at, :updated_at
    end
    show do
      configure :meta_object do
        label "Object"
      end
    end
    edit do
      field :subject
      field :meta_object do
        label "Object"
      end
      exclude_fields :created_at, :updated_at
    end
  end
end
