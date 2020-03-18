module Dates
  extend ActiveSupport::Concern

  def derive_date_not_before(date_str)
    if date_str
      regex = /(\d{4})(?:-(\d{2}))?(?:-(\d{2}))?/
      all = date_str.match(regex)
      y = all[1]
      m = all[2] || "01"
      d = all[3] || "01"

      "#{y}-#{m}-#{d}" if y
    end
  end

end
