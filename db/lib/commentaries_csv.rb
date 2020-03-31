class CommentariesCsv

  include Helpers

  def initialize(filename)
    @csv = Helpers.read_seed_file(filename)
  end

  def seed
    puts "Seeding commentaries"
    @csv.each_with_index do |row, index|
      print "." if index%20 == 0
      seed_row(row)
    end
    log_seeding(Commentary, @csv.length)
  end

  private

  # TODO currently spreadsheet only has single authors
  def add_authors(row, commentary)
    last, given = row["Commentary Author"].split(", ").map(&:strip)
    author = CommentaryAuthor.find_or_create_by(
      name_last: last,
      name_given: given
    )
    author.commentaries << commentary
    author.save
  end

  def add_events(row, commentary)
    items = row["Event Title"]
    if items
      items.split("\n").each do |item|
        news_item = Event.find_by(name: item.strip)
        news_item.commentaries << commentary
      end
    end
  end

  def add_news_items_or_works(row, commentary)
    items = row["Item Title"]
    if items
      items.split("\n").each do |item|
        news_item = NewsItem.find_by(article_title: item.strip)
        if news_item
          news_item.commentaries << commentary
        else
          # check if this is actually a work rather than a news item
          work = Work.find_by(title: item.strip)
          if work
            work.commentaries << commentary
          else
            puts "could not find #{item} in news items or works tables"
          end
        end
      end
    end
  end

  def add_poets(row, commentary)
    poets = row["Poet Name"]
    if poets
      poets.split("\n").each do |poet|
        person = find_or_create_poet(poet)
        person.commentaries << commentary
      end
    end
  end

  def seed_row(row)
    commentary = Commentary.create(
      name: row["Commentary Title"]
    )
    add_authors(row, commentary)
    add_news_items_or_works(row, commentary)
    add_poets(row, commentary)
    add_events(row, commentary)
  end

end
