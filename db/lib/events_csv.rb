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
        person.save
        # at the moment, everybody is listed as "poet"
        EventRole.create(
          person: person,
          role: "Poet",
          event: item
        )
      end
    end
  end

  def event_basics(row)
    Event.new(
      name: row["Event Title"],
      date: row["Event Date"],
      event_type: row["Event Type"],
      name_original: row["Event Original Name"],
    )
  end

  def seed_row(row)
    item = event_basics(row)
    item.location = create_location(row)
    create_roles(row, item)
    item.save
  end

end
