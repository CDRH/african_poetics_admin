class NewsCsv

  include Helpers

  def initialize(filename)
    @csv = read_seed_file(filename)
  end

  def seed
    puts "Seeding news"
    @csv.each_with_index do |row, index|
      print "." if index%20 == 0
      seed_row(row)
    end
    log_seeding(NewsItem, @csv.length)
  end

  private

  def create_tags(row)
    tag_list = row["Tags"]
    if tag_list
      tag_list.split(", ").map do |tag|
        Tag.find_or_create_by(name: tag)
      end
    end
  end

  def news_item_basics(row)
    NewsItem.new(
      article_title: row["Item Title"],
      item_type: row["Source"],
      date: row["Source Publication Date"],
      citation: row["Source Citation"],
      excerpt: row["Excerpt"],
      notes: row["Notes"]
    )
  end

  def seed_row(row)
    item = news_item_basics(row)
    item.tags += create_tags(row) || []
    item.save
  end

end
