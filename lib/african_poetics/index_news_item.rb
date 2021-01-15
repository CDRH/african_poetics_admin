class IndexNewsItem < Index

  def record_type
    "news"
  end

  def creator
    @record.authors.map do |a|
      {
        "name" => a.person.name,
        "id" => a.id,
        "role" => "Creator"
      }
    end
  end

  def date
    date_standardize(@record.date)
  end

  def date_not_after
    date_standardize(@record.date, before: false)
  end

  def date_not_before
    date
  end

  def description
    @record.summary
  end

  def keywords
    @record.tags.map { |t| t.name }
  end

  # NOTE this field is for the poet in the news item
  def person
    poets = @record.people
      .includes(:news_item_roles)
      .where(news_item_roles: { role: Role.find_by(name: "Poet") })
      .distinct
    poets.map do |author|
      {
        "name" => author.name,
        "role" => "Poet",
        "id" => author.id
      }
    end
  end

  def places
    if @record.publication && @record.publication.location
      @record.publication.location.name
    end
  end

  def publisher
    @record.publication.name if @record.publication
  end

  def source
    @record.source_link
  end

  # in addition to title and description
  def text_additional
    crt = get_names_from_list(creator)
    ppl = get_names_from_list(person)
    events = get_names_from_list(@record.events)
    wrk = get_names_from_list(works)
    [
      crt,
      events,
      keywords,
      places,
      ppl,
      publisher,
      @record.excerpt,
      type,
      wrk
    ]
  end

  def type
    @record.news_item_type.name if @record.news_item_type
  end

  def works
    @record.works.map { |w| w.name }
  end


end
