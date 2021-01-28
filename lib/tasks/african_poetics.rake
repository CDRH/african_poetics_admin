require "african_poetics/elasticsearch"
require "african_poetics/index"
require "african_poetics/index_commentary"
require "african_poetics/index_event"
require "african_poetics/index_news_item"
require "african_poetics/index_person"
require "african_poetics/index_work"

namespace :african_poetics do

  desc "one-time run: best guess assigning 'author' for news roles"
  task assign_news_item_author: :environment do
    # for news item roles, assume all critics are authors
    critic = Role.find_by(name: "Critic")
    if critic
      critic_roles = NewsItemRole.joins(:role).where(role: critic)
      critic_roles.each do |cr|
        puts "news item role critic: #{cr.id}"
        cr.update(author: true)
      end
    end
  end

  desc "one-time run: best guess assigning 'author' for work roles"
  task assign_work_author: :environment do
    # for work roles, if the work is a single author work
    #   if single role, assume author
    #   if multiple roles but same person, delete "author" role and assign other as author
    types = WorkType.where("name like ?", "Single Author%")
    works = Work.joins(:work_type).where(work_type: types)
    works.each do |work|
      wroles = work.work_roles
      next if wroles.count == 0
      if wroles.count == 1
        wroles.first.update(author: true)
      else
        # take note of the people listed as "authors"
        author_role = Role.find_by(name: "Author")
        authors = wroles.where(role: author_role)
        if authors.present?
          authors.each do |author|
            multiple_roles = wroles.where(person: author.person).where.not(role: author_role)
            if multiple_roles.present?
              multiple_roles.update_all(author: true)
              puts "work roles deleting #{author.id}"
              author.destroy
            end
          end
        end
      end
    end
  end

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

  desc "clears Elasticsearch index of this collection + category"
  task index_clear: :environment do
    es = Elasticsearch.new()
    es.clear
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

  desc "pushes contents of admin DB to frontend website and populates elasticsearch"
  task publish: :environment do

    Rake::Task["african_poetics:publish_db"].invoke
    Rake::Task["african_poetics:publish_es"].invoke

  end

  desc "copies admin DB to frontend DB"
  task publish_db: :environment do
    puts "Updating frontend database (this may take a moment to run)"

    location = File.expand_path(File.dirname(__FILE__))
    script_output = `#{location}/db_dump_admin_create_frontend.sh`

    # script_output includes echo statements, etc, so we want to make it available
    puts script_output
  end

  desc "populates elasticsearch using contents of admin DB"
  task publish_es: :environment do
    es = Elasticsearch.new()

    puts "Clearing Elasticsearch index"
    es.clear

    puts "Creating documents from database and posting to Elasticsearch"

    Commentary.all.each do |comm|
      IndexCommentary.new(comm, es).post
    end
    Event.all.each do |event|
      IndexEvent.new(event, es).post
    end
    NewsItem.all.each do |item|
      IndexNewsItem.new(item, es).post
    end
    Person.poet.each do |person|
      IndexPerson.new(person, es).post
    end
    Work.all.each do |work|
      IndexWork.new(work, es).post
    end
  end

  desc "one-time run: set permissions based on publication"
  task set_publication_permissions: :environment do
    # standardize the permissions by publication on each news item
    # each news item could conceivably have a different permission
    # but if it seems like in general it always follows the archive
    # we may want to rethink how the db fields are structured
    permissions = {
      "The Times" => "© Times Newspapers Limited.",
      "The Sunday Times" => "© Times Newspapers Limited.",
      "Financial Times" => "© The Financial Times Limited. All rights reserved.",
      "The Listener" => "© BBC logo 1996; BBC & THE LISTENER are trademarks of the British Broadcasting Corporation and are used under license."
    }
    permissions.each do |publication, permission|
      news = NewsItem.where(
        publication: Publication.where(name: publication)
      )
      news.update(permissions: permission)
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
