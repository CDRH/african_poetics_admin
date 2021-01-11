class IndexEvent < Index

  def record_type
    "event"
  end

  def date
    date_normalize(@record.date_not_before)
  end

  def date_display
    return nil if !@record.date
    # if this is YYYY-YYYY display as is
    if @record.date[/\d{4}-\d{4}/]
      @record.date
    else
      date_display_format(@record.date)
    end
  end

  def date_not_before
    date
  end

  # NOTE: this field might be slightly inaccurate
  # because the date field is a string and may have information
  # like YYYY-YYYY which we are not currently taking into account
  def date_not_after
    date_normalize(@record.date_not_before, before: false)
  end

  def description
    @record.summary
  end

  def person
    @record.people.map do |p|
      {
        "name" => p.name,
        "id" => p.id,
        "role" => "none"
      }
    end
  end

  def places
    @record.location.name if @record.location
  end

  def spatial
    # TODO coordinates for latlng
    l = @record.location
    if l
      [
        {
          "title" => l.name,
          "place_name" => l.place,
          "city" => l.city,
          "country" => l.country,
          "region" => l.region.name
        }
      ]
    else
      []
    end
  end

  # event type
  def type
    @record.event_type.name
  end

end
