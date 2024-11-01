RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == CancanCan ==
  # config.authorize_with :cancancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  config.default_items_per_page = 50
  config.sidescroll = true

  ##############
  # Navigation #
  ##############

  # Lower weights order groups

  # Add New and Edit

  config.model "NewsItem" do
    navigation_label "Add New and Edit"
    weight -5
  end

  # Edit Related Records

  config.model "Education" do
    navigation_label "Edit Records & Connections"
    weight -4
  end
  config.model "Event" do
    navigation_label "Edit Records & Connections"
    weight -4
  end
  config.model "Person" do
    navigation_label "Edit Records & Connections"
    weight -3
  end
  config.model "Relationship" do
    navigation_label "Edit Records & Connections"
    weight -3
  end
  config.model "Work" do
    navigation_label "Edit Records & Connections"
    weight -3
  end

  # Connections

  config.model "MetaCommentary" do
    label "Related Commentaries"
    navigation_label "Edit Related Roles"
    weight -1
  end
  config.model "NewsItemRole" do
    navigation_label "Edit Related Roles"
    weight -1
  end
  config.model "WorkRole" do
    navigation_label "Edit Related Roles"
    weight -1
  end

  # Reference Info

  config.model "Commentary" do
    navigation_label "Reference Info"
  end
  config.model "CommentaryAuthor" do
    navigation_label "Reference Info"
  end
  config.model "EventType" do
    navigation_label "Reference Info"
  end
  config.model "Gender" do
    navigation_label "Reference Info"
  end
  config.model "Location" do
    navigation_label "Reference Info"
  end
  config.model "NewsItemContentType" do
    label "News Item Content Type"
    navigation_label "Reference Info"
  end
  config.model "NewsItemType" do
    label "News Item Document Type"
    navigation_label "Reference Info"
  end
  config.model "Publication" do
    navigation_label "Reference Info"
  end
  config.model "Publisher" do
    navigation_label "Reference Info"
  end
  config.model "Region" do
    navigation_label "Reference Info"
  end
  config.model "RelationshipType" do
    navigation_label "Reference Info"
  end
  config.model "Repository" do
    label "Archive"
    navigation_label "Reference Info"
  end
  config.model "Role" do
    navigation_label "Reference Info"
  end
  config.model "Tag" do
    navigation_label "Reference Info"
  end
  config.model "University" do
    navigation_label "Reference Info"
  end
  config.model "WorkType" do
    navigation_label "Reference Info"
  end
end
