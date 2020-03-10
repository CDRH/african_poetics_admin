# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

require 'csv'

require_relative "lib/helpers.rb"
# works primarily with poets csv
require_relative "lib/poet_csv.rb"

# comment out if you wish to simply add onto existing data
Location.destroy_all
University.destroy_all
Person.destroy_all

poet_csv = PoetCsv.new("poets.csv")
puts "called once"
poet_csv.seed

# Call seeding methods
# seed_poets("poets.csv")
