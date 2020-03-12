# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_03_11_141636) do

  create_table "educations", force: :cascade do |t|
    t.integer "year_started"
    t.integer "year_ended"
    t.boolean "graduated"
    t.string "degree"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "person_id"
    t.integer "university_id"
    t.index ["person_id"], name: "index_educations_on_person_id"
    t.index ["university_id"], name: "index_educations_on_university_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.datetime "date"
    t.string "event_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "location_id"
    t.index ["location_id"], name: "index_events_on_location_id"
  end

  create_table "events_news_items", id: false, force: :cascade do |t|
    t.integer "event_id", null: false
    t.integer "news_item_id", null: false
  end

  create_table "events_people", id: false, force: :cascade do |t|
    t.integer "event_id", null: false
    t.integer "person_id", null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string "place"
    t.string "city"
    t.string "country"
    t.string "region"
    t.string "latlng"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "locations_people", id: false, force: :cascade do |t|
    t.integer "person_id", null: false
    t.integer "location_id", null: false
  end

  create_table "news_item_roles", force: :cascade do |t|
    t.integer "person_id"
    t.integer "news_item_id"
    t.string "role"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["news_item_id"], name: "index_news_item_roles_on_news_item_id"
    t.index ["person_id"], name: "index_news_item_roles_on_person_id"
  end

  create_table "news_items", force: :cascade do |t|
    t.string "article_title"
    t.string "item_type"
    t.datetime "date"
    t.text "citation"
    t.text "excerpt"
    t.text "notes"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "news_items_tags", id: false, force: :cascade do |t|
    t.integer "tag_id", null: false
    t.integer "news_item_id", null: false
  end

  create_table "people", force: :cascade do |t|
    t.string "poet_id"
    t.string "name_last"
    t.string "name_given"
    t.string "name_alt"
    t.string "gender"
    t.string "date_birth"
    t.string "date_death"
    t.boolean "cap"
    t.text "bibliography"
    t.text "biography"
    t.text "notes"
    t.text "citations"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "universities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "location_id"
    t.index ["location_id"], name: "index_universities_on_location_id"
  end

end
