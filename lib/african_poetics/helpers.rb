# NOTE: these are helpers copied over from Datura

module Helpers

  def date_display_format(date, nd_text:"unknown")
    # if "[none]" was specifically marked, then return that
    # as the display date, since that is more information than "unknown"
    return date if date == "[none]"
    date_hyphen = date_standardize(date)
    if date_hyphen
      y, m, d = date_hyphen.split("-").map { |s| s.to_i }
      date_obj = Date.new(y, m, d)
      date_obj.strftime("%B %-d, %Y")
    else
      nd_text
    end
  end

  def date_normalize(date, before: true)
    # if this person is alive we should not have a date_not_after
    return nil if !date || date == "Alive" || date == "[none]"
    date_standardize(date, before: before)
  end

  def date_standardize(date, before: true)
    if date
      if date.class != ActiveSupport::TimeWithZone
        y, m, d = date.to_s.split(/-|\//)
        if y && y.length == 4
          # use -1 to indicate that this will be the last possible
          m_default = before ? "01" : "-1"
          d_default = before ? "01" : "-1"
          m = m_default if !m
          d = d_default if !d

          if Date.valid_date?(y.to_i, m.to_i, d.to_i)
            date = Date.new(y.to_i, m.to_i, d.to_i)
          else
            puts "SOMETHING WRONG WITH DATE #{y}-#{m}-#{d}"
            return nil
          end
        else
          # if there's not even a year, can't do anything with this date
          return nil
        end
      end
      date.strftime("%Y-%m-%d")
    end
  end

end
