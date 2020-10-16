namespace :african_poetics do

  desc "attempts to parse citation field into separate work fields"
  task citation: :environment do

    Work.where.not(citation: nil).each do |work|
      if work.citation.include?("http")
        words = work.citation.split(" ")
        # not looking to alter the citation field, just to
        # copy url into the source_link field
        url = words.select { |w| w =~ URI::regexp }
        work.source_link = url.first if url
        puts "Updating work #{work.id} with url from citation"
        work.save
      end
    end

  end

  desc "ingests latitude and longitude into database"
  task ingest_location: :environment do
    # read CSV
    file = File.join(Rails.root, "lib/assets/locations.csv")
    csv = read_csv(file)

    csv.each do |row|
      next if !row["Id"] || !row["Id"][/^\d/]
      id = row["Id"].to_i
      record = Location.find(id)
      # check country just to make sure we're not wildly off base
      if record && record.country == row["Country"]
        record.latitude = row["Latitude"]
        record.longitude = row["Longitude"]
        record.save
      else
        puts "row #{id} does not match db entry #{id}"
      end
    end

  end

  private

  def read_csv(file_location, encoding: "utf-8")
    CSV.read(file_location, {
      encoding: encoding,
      headers: true,
      return_headers: true,
      skip_blanks: true
    })
  end

end
