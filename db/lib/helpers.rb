require 'csv'

module Helpers
  def combine_fields(row, *fields, same_length: true)
    values = fields.map do |field|
      row[field] ? row[field].chomp.split("\n") : []
    end
    # get the length of all the fields and crush them down
    # if there's exactly one length, then great! If not, error
    lengths = values.map(&:length)
    combined = []
    if same_length
      if lengths.uniq.length == 1
        first_column = values.shift
        combined = first_column.zip(*values)
      end
    else
      lengths.max.times do |i|
        combined << values.map { |v| v[i] }
      end
    end
    combined
  end

  def get_poet_name(fullname)
    if fullname
      lastname, remainder = fullname.split(",").map(&:strip)
      if remainder && remainder.include?("[")
        matches = remainder.match(/(.*)\[(.*)\]/)
        given = matches[1].strip if matches[1]
        alt = matches[2].strip if matches[2]
      else
        given = remainder || nil
        alt = nil
      end
      [ lastname, given, alt ]
    else
      [ nil, nil, nil ]
    end
  end

  def log_seeding(model, seed_length)
    count = model.all.length
    if count != seed_length
      puts "Something went wrong when loading model #{model}: loaded #{count} of #{seed_length}"
    else
      puts "#{count} records created for #{model}"
    end
  end

  def self.read_seed_file(filename)
    file = Rails.root.join('db', 'seeds', filename)
    if filename.include?(".csv")
      CSV.read(file, headers: true, encoding: "utf-8")
    else
      YAML.load_file(file)
    end
  end

  def self.seed_yaml(filename, model, field)
    file = self.read_seed_file(filename)
    file.each do |entry|
      model.find_or_create_by(field => entry)
    end
  end
end
