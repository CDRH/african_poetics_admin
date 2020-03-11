# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

require 'csv'

require_relative "lib/helpers.rb"
require_relative "lib/poet_csv.rb"
require_relative "lib/news_csv.rb"

# comment out if you wish to simply add onto existing data
Location.destroy_all
University.destroy_all
NewsItem.destroy_all
Person.destroy_all
Tag.destroy_all
Role.destroy_all

poet_csv = PoetCsv.new("poets.csv")
news_csv = NewsCsv.new("news.csv")
poet_csv.seed
news_csv.seed
