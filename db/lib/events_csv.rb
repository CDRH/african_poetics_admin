class EventsCsv

  include Helpers

  def initialize(filename, events_mapping)
    @csv = read_seed_file(filename)
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

  def create_event(row)
    # original event name SHOULD have been on the news spreadsheet
    # so grab that information and associate the item
  end

  def create_location(row)
    loc = row["Event Location"]
    if loc
      region, country, city, place = loc.split(". ")
      Location.find_or_create_by(
        region: region,
        country: country,
        city: city,
        place: place
      )
    end
  end

  def create_roles(row, event)
    poet_list = row["Poets"]
    if poet_list
      poets = poet_list.split("\n").map do |poet|
        names = get_poet_name(poet)
        person = Person.find_or_create_by(
          name_last: names[0],
          name_given: names[1],
          name_alt: names[2]
        )
        person.events << event
        person.save
      end
    end
  end

  def event_basics(row)
    Event.new(
      name: row["Event Title"],
      date: row["Event Date"],
      event_type: row["Event Type"],
    )
  end

  def seed_row(row)
    event = event_basics(row)
    loc = create_location(row)
    if loc
      event.location = loc if loc
      create_roles(row, event)
      associate_news_item(row, event)
      event.save
    else
      puts "Problem with #{row["Event Original Title"]}"
    end
  end

end
