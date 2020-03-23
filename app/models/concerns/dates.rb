module Dates
  extend ActiveSupport::Concern

  def set_date_not_before
    if date
      regex = /(\d{4})(?:-(\d{2}))?(?:-(\d{2}))?/
      all = date.match(regex)
      y = all[1]
      m = all[2] || "01"
      d = all[3] || "01"

      self.date_not_before = "#{y}-#{m}-#{d}" if y
    end
  end

  def year
    if date
      if date.class == ActiveSupport::TimeWithZone
        date.strftime("%Y")
      else
        # manually pull out string
        date[/^\d{4}/]
      end
    elsif defined? date_not_before
      # this will always be a date time
      date_not_before.strftime("%Y")
    end
  end

end
