class IndexPerson < Index

  def record_type
    "person"
  end

  private

  # first letter of last name
  # TODO this shouldn't go in this field permanently
  def alternative
    @record.name_last[0]
  end

  # using birthday for now
  def date
    date_normalize(@record.date_birth)
  end

  def date_display
    date_display_format(date)
  end

  def date_not_before
    date_normalize(@record.date_birth)
  end

  def date_not_after
    date_normalize(@record.date_death, before: false)
  end

  def description
    @record.short_biography
  end

  def keywords
    # TODO is this a good location for educations?
    @record.educations.map { |edu| edu.university_name }
  end

  def person
    [
      {
        "id" => @id,
        "name" => title,
        "role" => "Self"
      }
    ]
  end

  def places
    bp = @record.place_of_birth
    if bp
      bp.country
    end
  end

  def source
    # using news item article titles for now, not sure this is ideal
    @record.news_items.map { |n| n.name }
  end

  def spatial
    if @record.regions
      # TODO should probably put full locations here
      # but only using regions for speed's sake
      @record.regions.map { |r| { "region" => r.name } }
    else
      []
    end
  end

  # NOTE only poets should be getting indexed,
  # so there is no need to distinguish which are
  # major african poets here
  # def subcategory
  # end

  def text_additional
    # education?
    [
      source,
      works
    ]
  end

  def works
    @record.works.map { |w| w.name }
  end

end
