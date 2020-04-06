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

    region, country, city = edu[1].split(".").map(&:strip) if edu[1]

    r = Region.find_or_create_by(name: region)

    uni.location = Location.find_or_create_by(
      city: city,
      country: country,
      region: r
    )
    uni.save
    uni
  end

  def create_works(row, person)
    works_list = row["Poet BIB"]
    if works_list
      works_list.split("\n").each do |work|
        w = work.match(/^(.*)(?:\((\d{4})\)?)/)
        if w
          title = w[1].strip if w[1]
          # NOTE: work MUST have a year so adding placeholder if empty
          year = w[2] ? w[2].strip : 0
          # most of these have dates we can separate out
          new_work = Work.create(
            title: title,
            year: year,
            citation: work
          )
          new_work.save

          # If this person wrote a work of poetry, they should
          # be included as a poet AND as an author, according to
          # meeting on 4/3
          WorkRole.create(
            work: new_work,
            person: person,
            role: "Poet"
          )
          WorkRole.create(
            work: new_work,
            person: person,
            role: "Author"
          )
        end
      end
    end
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
    places = row["Poet Nationality (Country Name) "]
    if places && places != "[none]"
      places.split("\n").map do |place|
        if place
          region, country = place.split(".").map(&:strip)
          r = Region.find_or_create_by(name: region)

          Location.find_or_create_by(
            # must have ALL fields filled out or else could grab wrong record
            # TODO warning nationality does NOT have region in the CSV
            # so we will need to add that there or look it up here!
            place: nil,
            city: nil,
            country: country,
            region: r,
            latlng: nil
          )
        end
      end
    end
  end

  def person_basics(row)
    name_str = row["Poet Name (Last name, first name[Alternate])"]
    person = find_or_create_poet(name_str)
    person.poet_id = row["Poet ID"]
    person.gender = row["Poet Gender"]
    person.date_birth = row["DOB (YYYY-MM-DD)"]
    person.date_death = row["DOD (YYYY-MM-DD)"]
    person.bibliography = row["Poet BIB"]
    person.short_biography = row["Short Bio"]
    person.notes = row["Notes"]
    person.citations = row["BIO INFO"]
    # if a person is appearing on this spreadsheet, then we can
    # assume that they are a major african poet
    # other poets added from other spreadsheet may not fit that criteria
    person.major_african_poet = true
    person
  end

  def seed_row(row)

    person = person_basics(row)
    person.locations += nationalities(row) || []
    # assume this person is done if they are being imported
    person.complete = true
    person.save

    create_works(row, person)
    generate_education_information(row, person)

  end

end
