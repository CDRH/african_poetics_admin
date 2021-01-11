# App Config

settings = YAML.load_file("#{Rails.root}/config/private.yml")[Rails.env]

ES_RAKE_SETTINGS = {
  "category" => settings["es_category"],
  "collection" => settings["es_collection"],
  "index" => settings["es_index"],
  "path" => settings["es_path"],
}
