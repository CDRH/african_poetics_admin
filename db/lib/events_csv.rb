class EventsCsv

  include Helpers

  def initialize(filename)
    @csv = read_seed_file(filename)
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

  def create_roles(row, item)
    poet_list = row["Poets"]
    if poet_list
      poets = poet_list.split("\n").map do |poet|
        names = get_poet_name(poet)
        person = Person.find_or_create_by(
          name_last: names[0],
          name_given: names[1],
          name_alt: names[2]
        )
        person.events << item
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

  def find_event(row)
    # this event may have been previously created by the
    # news.csv, so let's look for it under its original name
    # and then RENAME it!

    e = Event.find_by(name: row["Event Original Title"])
    # is there already an event by that name that's filled out?
    # we don't want to overwrite information, so in that case make
    # a new event. Otherwise, just fill in the updated information

    e = e || Event.new

    if e.date || e.event_type
      puts "ALREADY EXISTS"
      e = Event.new(
        name: row["Event Title"],
        date: row["Event Date"],
        event_type: row["Event Type"]
      )
    else
      puts "should have news_items?"
      puts e.news_items.length
      e.update(
        # use the corrected title, rather than the original
        name: row["Event Title"],
        date: row["Event Date"],
        event_type: row["Event Type"]
      )
    end
    e
  end

  def seed_row(row)
    item = find_event(row)
    loc = create_location(row)
    if loc
      item.location = loc if loc
      create_roles(row, item)
      item.save
    else
      puts "Problem with #{item.name}: no location"
    end
  end

end
