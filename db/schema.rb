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

ActiveRecord::Schema.define(version: 2021_01_13_150806) do

  create_table "commentaries", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.text "name"
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "commentaries_commentary_authors", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.bigint "commentary_id", null: false
    t.bigint "commentary_author_id", null: false
  end

  create_table "commentaries_events", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.bigint "commentary_id", null: false
    t.bigint "event_id", null: false
  end

  create_table "commentaries_news_items", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.bigint "commentary_id", null: false
    t.bigint "news_item_id", null: false
  end

  create_table "commentaries_people", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.bigint "commentary_id", null: false
    t.bigint "person_id", null: false
  end

  create_table "commentaries_works", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.bigint "commentary_id", null: false
    t.bigint "work_id", null: false
  end

  create_table "commentary_authors", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "name_last"
    t.string "name_given"
    t.string "name_title"
    t.text "short_biography"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "educations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.integer "year_ended"
    t.boolean "graduated"
    t.string "degree"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "person_id"
    t.bigint "university_id"
    t.boolean "complete"
    t.index ["person_id"], name: "index_educations_on_person_id"
    t.index ["university_id"], name: "index_educations_on_university_id"
  end

  create_table "event_types", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "description"
  end

  create_table "events", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "name"
    t.datetime "date_not_before"
    t.string "date"
    t.text "summary"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "location_id"
    t.bigint "event_type_id"
    t.boolean "complete"
    t.index ["event_type_id"], name: "index_events_on_event_type_id"
    t.index ["location_id"], name: "index_events_on_location_id"
  end

  create_table "events_news_items", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.bigint "news_item_id", null: false
  end

  create_table "events_people", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.bigint "person_id", null: false
  end

  create_table "genders", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "locations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "place"
    t.string "city"
    t.string "country"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "region_id"
    t.string "local_place"
    t.string "county_township"
    t.string "state_province_territory"
    t.decimal "latitude", precision: 10, scale: 7
    t.decimal "longitude", precision: 10, scale: 7
    t.index ["region_id"], name: "index_locations_on_region_id"
  end

  create_table "locations_people", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.bigint "person_id", null: false
    t.bigint "location_id", null: false
  end

  create_table "meta_commentaries", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.integer "subject_id"
    t.integer "meta_object_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "news_item_content_types", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "news_item_roles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.bigint "person_id"
    t.bigint "news_item_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "role_id"
    t.boolean "author", default: false
    t.index ["news_item_id"], name: "index_news_item_roles_on_news_item_id"
    t.index ["person_id"], name: "index_news_item_roles_on_person_id"
    t.index ["role_id"], name: "index_news_item_roles_on_role_id"
  end

  create_table "news_item_types", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "description"
  end

  create_table "news_items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "article_title"
    t.datetime "date"
    t.text "excerpt"
    t.text "summary"
    t.text "notes"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "publication_id"
    t.bigint "news_item_type_id"
    t.boolean "complete"
    t.string "source_page_no"
    t.text "source_link"
    t.datetime "source_access_date"
    t.text "permissions"
    t.bigint "news_item_content_type_id"
    t.index ["news_item_content_type_id"], name: "index_news_items_on_news_item_content_type_id"
    t.index ["news_item_type_id"], name: "index_news_items_on_news_item_type_id"
    t.index ["publication_id"], name: "index_news_items_on_publication_id"
  end

  create_table "news_items_repositories", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.bigint "repository_id", null: false
    t.bigint "news_item_id", null: false
  end

  create_table "news_items_tags", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.bigint "tag_id", null: false
    t.bigint "news_item_id", null: false
  end

  create_table "news_items_works", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.bigint "work_id", null: false
    t.bigint "news_item_id", null: false
  end

  create_table "people", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "name_last"
    t.string "name_given"
    t.string "name_alt"
    t.string "date_birth"
    t.string "date_death"
    t.text "bibliography"
    t.text "short_biography"
    t.text "notes"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "complete"
    t.boolean "major_african_poet"
    t.bigint "gender_id"
    t.bigint "place_of_birth_id"
    t.index ["gender_id"], name: "index_people_on_gender_id"
    t.index ["place_of_birth_id"], name: "index_people_on_place_of_birth_id"
  end

  create_table "publications", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "location_id"
    t.bigint "repository_id"
    t.index ["location_id"], name: "index_publications_on_location_id"
    t.index ["repository_id"], name: "index_publications_on_repository_id"
  end

  create_table "publishers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "location_id"
    t.index ["location_id"], name: "index_publishers_on_location_id"
  end

  create_table "regions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "description"
  end

  create_table "relationship_types", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "relationships", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.integer "subject_id"
    t.integer "rel_object_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "relationship_type_id", null: false
    t.index ["relationship_type_id"], name: "index_relationships_on_relationship_type_id"
  end

  create_table "repositories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "location_id"
    t.index ["location_id"], name: "index_repositories_on_location_id"
  end

  create_table "roles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tags", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "description"
  end

  create_table "universities", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "location_id"
    t.index ["location_id"], name: "index_universities_on_location_id"
  end

  create_table "work_roles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.bigint "person_id"
    t.bigint "work_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "role_id"
    t.boolean "author", default: false
    t.index ["person_id"], name: "index_work_roles_on_person_id"
    t.index ["role_id"], name: "index_work_roles_on_role_id"
    t.index ["work_id"], name: "index_work_roles_on_work_id"
  end

  create_table "work_types", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "description"
  end

  create_table "works", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "title"
    t.integer "year"
    t.text "citation"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "work_type_id"
    t.bigint "location_id"
    t.boolean "complete"
    t.bigint "publisher_id"
    t.string "page_no"
    t.string "issue"
    t.string "volume"
    t.text "source_link"
    t.index ["location_id"], name: "index_works_on_location_id"
    t.index ["publisher_id"], name: "index_works_on_publisher_id"
    t.index ["work_type_id"], name: "index_works_on_work_type_id"
  end

  add_foreign_key "people", "locations", column: "place_of_birth_id"
  add_foreign_key "publications", "repositories"
  add_foreign_key "relationships", "relationship_types"
  add_foreign_key "works", "locations"
end
