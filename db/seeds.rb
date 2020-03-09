# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

require 'csv'

def combine_fields(row, *fields, same_length: true)
  values = fields.map do |field|
    row[field] ? row[field].chomp.split("\n") : []
  end
  # get the length of all the fields and crush them down
  # if there's exactly one length, then great! If not, error
  lengths = values.map(&:length)
  combined = []
  if same_length
    if lengths.uniq.length == 1
      first_column = values.shift
      combined = first_column.zip(*values)
    end
  else
    lengths.max.times do |i|
      combined << values.map { |v| v[i] }
    end
  end
  combined
end

def get_poet_name(fullname)
  lastname, remainder = fullname.split(",").map(&:strip)
  if remainder.include?("[")
    matches = remainder.match(/(.*)\[(.*)\]/)
    given = matches[1].strip if matches[1]
    alt = matches[2].strip if matches[2]
  else
    given = remainder
    alt = nil
  end
  [ lastname, given, alt ]
end

def log_seeding(model, seed_length)
  count = model.all.length
  if count != seed_length-1
    puts "Something went wrong when loading model #{model}: loaded #{count} of #{seed_length}"
  else
    puts "#{count} records created for #{model}"
  end
end

def read_seed_file(filename)
  file = Rails.root.join('db', 'seeds', filename)
  CSV.read(file, headers: true, encoding: "utf-8")
end

def seed_poets(seed_filename)
  puts "Seeding poets"
  seeds = read_seed_file(seed_filename)

  seeds.each_with_index do |seed, index|
    print "." if index%20 == 0
    # each row of the poet spreadsheet should have a unique poet
    last, given, alt = get_poet_name(seed["Poet Name (Last name, first name[Alternate])"])
    person = Person.create(
      poet_id: seed["Poet ID"],
      # split up name into components
      name_last: last,
      name_given: given,
      name_alt: alt,
      gender: seed["Poet Gender"],
      date_birth: seed["DOB (YYYY-MM-DD)"],
      date_death: seed["DOD (YYYY-MM-DD)"],
      cap: seed["In CAP"] == "Y",
      bibliography: seed["Poet BIB"],
      notes: seed["Notes"],
      citations: seed["BIO INFO"]
    )

    person.location = Location.find_or_create_by(
      # must have ALL fields filled out or else could grab wrong record
      # TODO warning nationality does NOT have region in the CSV
      # so we will need to add that there or look it up here!
      city: nil,
      country: seed["Poet Nationality (Country Name) "],
      region: nil,
      latlng: nil
    )
    person.save

    educations = combine_fields(seed,
      "Poet University Name",
      "Poet University Place",
      "Poet University Date Graduated",
      same_length: false
    )
    educations.each do |edu|
      next if edu[0] == "[none]" && edu[1] == "[none]" && edu[2] == "[none]"
      # lookup / create university first
      # TODO going to need to standardize how the degrees are listed
      # before this can be accurately seeded
      uni = University.find_or_create_by(name: edu[0])
      # split location to city, country, region (TODO region not in spreadsheet)
      city, country, region = edu[1].split(", ") if edu[1]
      uni.location = Location.find_or_create_by(city: city, country: country, region: region)
      uni.save

      grad = edu[2][/^\d{4}/] if edu[2]
      # look for degree in two fields
      degree = edu[2][/\((.*)\)/,1] if edu[2]
      if !degree
        degree = edu[0][/\((.*)\)/,1] if edu[0]
      end
      education = Education.create(
        year_started: nil,
        year_ended: edu[2],
        # TODO only getting the first year listed, which means leaving out
        # fancy things like "1950s" or "1928-1930" type listings
        graduated: grad,
        # TODO going to be grabbing the rest of the string, essentially
        # which isn't what we ultimately want
        degree: degree,
      )
      education.person = person
      education.university = uni
      education.save
    end
    # TODO Poet University Name
    # TODO Poet University Place
    # TODO Poet University Date Graduated

  end
  log_seeding(Person, seeds.length)
end

# DESTROY ALL DB RECORDS BEFORE STARTING
# temp for development
Person.destroy_all
Location.destroy_all
# I believe that education should be destroyed when people are
# but I'm not sure it's working
Education.destroy_all

# Call seeding methods
seed_poets("poets.csv")
