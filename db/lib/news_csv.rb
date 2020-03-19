class NewsCsv

  include Helpers

  attr_reader :events_mapping

  def initialize(filename)
    @csv = read_seed_file(filename)
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
      names = get_poet_name(p_name)
      person = Person.find_or_create_by(
        name_last: names[0],
        name_given: names[1],
        name_alt: names[2]
      )
      person.save
      NewsItemRole.create(
        person: person,
        role: p_role.strip,
        news_item: item
      )
    end
  end

  def create_tags(row)
    tag_list = row["Tags"]
    if tag_list
      tag_list.split(", ").map do |tag|
        Tag.find_or_create_by(name: tag)
      end
    end
  end

  def find_publisher(row)
    publisher = row["Source Title"]
    Publisher.find_or_create_by(name: publisher)
  end

  def news_item_basics(row)
    NewsItem.new(
      article_title: row["Item Title"],
      item_type: row["Source"],
      date: row["Source Publication Date"],
      citation: row["Source Citation"],
      excerpt: row["Excerpt"],
      notes: row["Notes"]
    )
  end

  def seed_row(row)
    item = news_item_basics(row)
    item.publisher = find_publisher(row)
    item.tags += create_tags(row) || []
    create_roles(row, item)
    create_events(row, item)
    item.save
  end

end
