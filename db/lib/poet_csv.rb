class PoetCsv

  include Helpers

  def initialize(filename)
    @csv = Helpers.read_seed_file(filename)
  end

  def seed
    puts "Seeding poets"
    @csv.each_with_index do |row, index|
      print "." if index%20 == 0
      seed_row(row)
    end
    log_seeding(Person, @csv.length)
  end

  private

  def create_university(edu)
    uni = University.find_or_create_by(name: edu[0])
    # split location to city, country, region (TODO region not in spreadsheet)
    city, country, region = edu[1].split(", ") if edu[1]
    uni.location = Location.find_or_create_by(
      city: city,
      country: country,
      region: region
    )
    uni.save
    uni
  end

  def education_empty?(edu)
    edu[0] == "[none]" && edu[1] == "[none]" && edu[2] == "[none]"
  end

  def generate_education_information(row, person)
    educations = combine_fields(row,
      "Poet University Name",
      "Poet University Place",
      "Poet University Date Graduated",
      "Poet University Degree",
      same_length: false
    )
    educations.each do |edu|
      next if education_empty?(edu)

      uni = create_university(edu)
      grad_date = edu[2].to_i == 0 ? nil : edu[2]
      degree = edu[3]

      education = Education.create(
        year_ended: grad_date,
        graduated: !!grad_date,
        degree: degree,
      )
      education.person = person
      education.university = uni
      education.save
    end
  end

  def nationalities(row)
    countries = row["Poet Nationality (Country Name) "]
    if countries
      countries.split("\n").map do |country|
        Location.find_or_create_by(
          # must have ALL fields filled out or else could grab wrong record
          # TODO warning nationality does NOT have region in the CSV
          # so we will need to add that there or look it up here!
          city: nil,
          country: country,
          region: nil,
          latlng: nil
        )
      end
    end
  end

  def person_basics(row)
    # split up name into components
    last, given, alt = get_poet_name(
      row["Poet Name (Last name, first name[Alternate])"]
    )
    Person.new(
      poet_id: row["Poet ID"],
      name_last: last,
      name_given: given,
      name_alt: alt,
      gender: row["Poet Gender"],
      date_birth: row["DOB (YYYY-MM-DD)"],
      date_death: row["DOD (YYYY-MM-DD)"],
      cap: row["In CAP"] == "Y",
      bibliography: row["Poet BIB"],
      notes: row["Notes"],
      citations: row["BIO INFO"]
    )
  end

  def seed_row(row)

    person = person_basics(row)
    person.locations += nationalities(row) || []
    person.save

    generate_education_information(row, person)

  end

end
