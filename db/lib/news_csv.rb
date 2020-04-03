class NewsCsv

  include Helpers

  attr_reader :events_mapping

  def initialize(filename)
    @csv = Helpers.read_seed_file(filename)
    @events_mapping = {}
  end

  def seed
    puts "Seeding news"
    @csv.each_with_index do |row, index|
      print "." if index%20 == 0
      seed_row(row)
    end
    log_seeding(NewsItem, @csv.length)
  end

  private

  def create_events(row, item)
    # events used to be stored on the news items spreadsheet
    # but recently got their own spreadsheet for more detailed entry

    # alas, it turns out that new events MUST have a location
    # or bust, and since we don't know the location yet
    # let's just collect the event title mappings
    events = row["Event Title"]
    if events
      events.split("\n").each do |event|
        if event.present?
          event.strip!
          if @events_mapping.key?(event)
            @events_mapping[event] << item.id
          else
            @events_mapping[event] = [ item.id ]
          end
        end
      end
    end
  end

  def create_roles(row, item)
    people_roles = {}

    if row["Poet Name (Last, First Middle) [Alternate Name]"]
      row["Poet Name (Last, First Middle) [Alternate Name]"].split("\n").each do |p|
        people_roles[p] = "Poet"
      end
    end
    if row["Mentioned Poets"]
      row["Mentioned Poets"].split("\n").each do |p|
        people_roles[p] = "Mentioned Poet"
      end
    end
    # TODO skipping relative part because it's not always clear which
    # poet they go with!

    # SKIPPING Critic/Reporter field because it's duplicated in Mentioned, Other
    if row["Mentioned, Other | Profession"]
      row["Mentioned, Other | Profession"].split("\n").each do |p|
        p_name, profession = p.split("|")
        people_roles[p_name] = profession
      end
    end

    people_roles.each do |p_name, p_role|
      role = p_role ? p_role.strip : nil
      person = find_or_create_poet(p_name)
      person.save
      NewsItemRole.create(
        person: person,
        role: role,
        news_item: item
      )
    end
  end

  def create_tags(row)
    tag_list = row["Tags"]
    if tag_list
      tag_list.split(/,,? ?/).map do |tag|
        tag.strip!
        Tag.find_or_create_by(name: tag)
      end
    end
  end

  def create_other_works(row, item)
    # these works are not the poet's publications the article is focusing on,
    # but rather are works in the article which reference the poets being
    # discussed (for example, reference to a book about the history of Ghana poets)
    # therefore, they should be added as a related work to this news item
    # but all the poets in the news item should be added as
    # "mentioned poet" rather than as a "poet" when it comes to this work

    pubs = row["Publication Poet Mentioned In"]
    if pubs
      # get all the poets
      author_list = row["Poet Name (Last, First Middle) [Alternate Name]"]
      authors = []
      if author_list
        author_list.split("\n").map do |a|
          authors << find_or_create_poet(a)
        end
      end

      pubs.split("\n").each do |pub|
        title = pub.strip
        next if title.blank?
        work = Work.find_or_create_by(title: title)

        authors.each do |author|
          WorkRole.create(
            work: work,
            person: author,
            role: "Mentioned Poet"
          )
        end
      end
    end
  end

  def create_works(row, item)
    # match up publication details and poet pub types
    # find or create a work for this particular item
    # associate with the current news_item
    # find ALL poets listed in news_item and associate with work
    #   this may be inaccurate but it's better to have too many
    pubs = combine_fields(
      row,
      "Poet Publication Details",
      "Poet Pub Type",
      same_length: false
    )

    author_list = row["Poet Name (Last, First Middle) [Alternate Name]"]
    authors = []
    if author_list
      author_list.split("\n").map do |a|
        authors << find_or_create_poet(a)
      end
    end

    pubs.each do |pub|
      title = pub[0].strip
      next if title.blank?

      work = Work.find_or_create_by(title: title)

      work_type = pub[1] ? pub[1].strip : nil
      if work_type
        pub_type = WorkType.find_or_create_by(name: work_type)
        work.work_type = pub_type
      end

      # blindly try to find a year and hope it's right
      year = title[/\d{4}/]
      work.year = year
      # ultimately this field will need to be cleaned up, but populating what we can for now!
      work.citation = title

      work.news_items << item
      work.save

      # for each person, make a role of "Poet" I guess
      authors.each do |author|
        WorkRole.create(
          work: work,
          person: author,
          role: "Poet"
        )
      end
    end

  end

  def find_publisher(row)
    publisher = row["Source Title"]
    Publisher.find_or_create_by(name: publisher)
  end

  def find_type(row)
    type = row["Source"]
    NewsItemType.find_or_create_by(name: type)
  end

  def news_item_basics(row)
    NewsItem.new(
      article_title: row["Item Title"],
      date: row["Source Publication Date"],
      citation: row["Source Citation"],
      excerpt: row["Excerpt"],
      notes: row["Notes"]
    )
  end

  def seed_row(row)
    item = news_item_basics(row)
    item.news_item_type = find_type(row)
    item.publisher = find_publisher(row)
    item.tags += create_tags(row) || []
    # assume this news item is done if it is being imported
    item.complete = true
    item.save
    create_events(row, item)
    create_roles(row, item)
    create_works(row, item)
    create_other_works(row, item)
  end

end
