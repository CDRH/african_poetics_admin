# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

require 'csv'

require_relative "lib/helpers.rb"
require_relative "lib/commentaries_csv.rb"
require_relative "lib/events_csv.rb"
require_relative "lib/news_csv.rb"
require_relative "lib/poet_csv.rb"

# comment out if you wish to simply add onto existing data
Commentary.destroy_all
CommentaryAuthor.destroy_all
Event.destroy_all
EventType.destroy_all
Location.destroy_all
NewsItem.destroy_all
NewsItemRole.destroy_all
NewsItemType.destroy_all
Person.destroy_all
Publisher.destroy_all
Repository.destroy_all
Tag.destroy_all
University.destroy_all
Work.destroy_all
WorkRole.destroy_all
WorkType.destroy_all

Helpers.seed_yaml("news_item_types.yml", NewsItemType, "name")

news_csv = NewsCsv.new("news.csv")
news_csv.seed
poet_csv = PoetCsv.new("poets.csv")
poet_csv.seed
events_csv = EventsCsv.new("events.csv", news_csv.events_mapping)
events_csv.seed
commentaries_csv = CommentariesCsv.new("commentaries.csv")
commentaries_csv.seed
