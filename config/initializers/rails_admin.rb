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

  # Navigation
  # Biographic Info
  # Lower weights move this group first
  config.model "NewsItem" do
    navigation_label "Biographic Info"
    weight -3
  end
  config.model "Person" do
    navigation_label "Biographic Info"
    weight -3
  end
  config.model "Event" do
    navigation_label "Biographic Info"
    weight -2
  end
  config.model "Work" do
    navigation_label "Biographic Info"
    weight -2
  end

  # Connections
  # Lower weights move this group second
  config.model "Education" do
    navigation_label "Connections"
    weight -1
  end
  config.model "MetaCommentary" do
    navigation_label "Connections"
    weight -1
  end
  config.model "NewsItemRole" do
    navigation_label "Connections"
    weight -1
  end
  config.model "Relationship" do
    navigation_label "Connections"
    weight -1
  end
  config.model "WorkRole" do
    navigation_label "Connections"
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
  config.model "NewsItemType" do
    label "Document Type"
    navigation_label "Reference Info"
  end
  config.model "Publisher" do
    label "Publication"
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
