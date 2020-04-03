class EventsCsv

  include Helpers

  def initialize(filename, events_mapping)
    @csv = Helpers.read_seed_file(filename)
    @events_mapping = events_mapping
  end

  def seed
    puts "Seeding events"
    @csv.each_with_index do |row, index|
      print "." if index%20 == 0
      seed_row(row)
    end
    log_seeding(Event, @csv.length)
  end

  private

  def add_people(row, event)
    poet_list = row["Poets"]
    if poet_list
      poets = poet_list.split("\n").map do |poet|
        person = find_or_create_poet(poet)
        person.events << event
        person.save
      end
    end
  end

  def associate_news_item(row, event)
    # use original title to look up news items
    # that might be associated with this particular event

    original = row["Event Original Title"]
    original.strip! if original
    if @events_mapping.key?(original)
      @events_mapping[original].each do |news_item_id|
        news_item = NewsItem.find(news_item_id)
        if news_item
          event.news_items << news_item
        end
      end
    else
      puts ".#{event.name}. FAILED"
    end
  end

  def create_event_type(row)
    EventType.find_or_create_by(name: row["Event Type"])
  end

  def create_location(row)
    loc = row["Event Location"]
    if loc
      region, country, city, place = loc.split(". ").map(&:strip)
      r = Region.find_or_create_by(name: region)

      Location.find_or_create_by(
        region: r,
        country: country,
        city: city,
        place: place
      )
    end
  end

  def event_basics(row)
    Event.new(
      name: row["Event Title"],
      date: row["Event Date"]
    )
  end

  def seed_row(row)
    event = event_basics(row)
    event.event_type = create_event_type(row)
    # assume this event is done if it is being imported
    event.complete = true
    loc = create_location(row)
    if loc
      event.location = loc if loc
      add_people(row, event)
      associate_news_item(row, event)
      event.save
    else
      puts "Problem with #{row["Event Original Title"]}"
    end
  end

end
