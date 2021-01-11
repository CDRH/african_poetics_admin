class IndexWork < Index

  def record_type
    "work"
  end

  def creator
    if @record.authors
      @record.authors.map do |a|
        {
          name: a.name,
          id: a.id,
          role: "Author"
        }
      end
    end
  end

  def date
    date_normalize(@record.year)
  end

  def date_not_after
    date_normalize(@record.year, before: false)
  end

  def date_not_before
    date
  end

  def date_display
    @record.year
  end

  def description
    @record.citation
  end

  def places
    if @record.publisher && @record.publisher.location
      [ @record.publisher.location.name ]
    end
  end

  def publisher
    @record.publisher.name if @record.publisher
  end

  # TODO latlng coordinates
  def spatial
    if @record.publisher && @record.publisher.location
      l = @record.publisher.location
      [
        {
          "title" => l.name,
          "city" => l.city,
          "country" => l.country,
          "region" => l.region.name
        }
      ]
    end
  end

  def type
    if @record.work_type
      t = @record.work_type.name
      t.sub("|", ", ") if t
    end
  end

end
