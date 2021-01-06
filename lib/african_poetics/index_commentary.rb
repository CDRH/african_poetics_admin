class IndexCommentary < Index

  def record_type
    "commentary"
  end

  def creator
    @record.commentary_authors.map do |author|
      {
        "id" => author.id,
        "name" => author.name,
        "role" => "Author"
      }
    end
  end

  def description
    @record.content
  end

  # abusing this field in order to put events somewhere
  def keywords
    @record.events.map { |e| e.name }
  end

  def person
    # all people the commentary discusses
    @record.people.map do |p|
      {
        "id" => p.id,
        "name" => p.name,
        "role" => "subject"
      }
    end
  end

  # abusing this field in order to put news items somewhere
  def subjects
    @record.news_items.map { |ni| ni.name }
  end

  def text_additional
    auth = []
    @record.commentary_authors.each do |a|
      auth << a.name
      auth << a.short_biography
    end
    auth
  end

  def works
  @record.works.map { |w| w.name }
  end

end
