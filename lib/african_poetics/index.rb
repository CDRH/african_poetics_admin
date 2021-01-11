require "net/http"
require "uri"

require "african_poetics/fields"
require "african_poetics/helpers"

class Index
  include Fields
  include Helpers

  def initialize(record, es_instance)
    @es = es_instance
    @record = record
    @record_type = record_type
    @id = get_id
  end

  def get_id
    "ap.#{@record_type}.#{@record.id}"
  end

  def post
    @es.post_document(transform)
  end

  def record_type
    # override in child classes
    "none"
  end

  def transform
    @json = {}
    @json["identifier"] = identifier

    # categories
    @json["category"] = category
    @json["subcategory"] = subcategory
    @json["data_type"] = data_type
    @json["collection"] = collection
    @json["collection_desc"] = collection_desc
    @json["subjects"] = subjects

    # dates
    @json["date"] = date
    @json["date_not_after"] = date_not_after
    @json["date_not_before"] = date_not_before
    @json["date_display"] = date_display

    # descriptions
    @json["alternative"] = alternative
    @json["description"] = description
    @json["title"] = title
    @json["title_sort"] = title_sort
    @json["topics"] = topics

    # other metadata
    @json["format"] = format
    @json["language"] = language
    @json["languages"] = languages
    @json["relation"] = relation
    @json["type"] = type
    @json["extent"] = extent
    @json["medium"] = medium
    @json["spatial"] = spatial

    # people
    @json["person"] = person
    @json["contributor"] = contributor
    @json["creator"] = creator
    @json["recipient"] = recipient

    # publishing
    @json["publisher"] = publisher
    @json["rights"] = rights
    @json["rights_uri"] = rights_uri
    @json["rights_holder"] = rights_holder
    @json["source"] = source

    # references
    @json["keywords"] = keywords
    @json["places"] = places
    @json["works"] = works

    # text
    @json["annotations_text"] = annotations_text
    @json["text"] = text

    # uris
    @json["uri"] = uri
    @json["uri_data"] = uri_data
    @json["uri_html"] = uri_html
    @json["image_id"] = image_id

    @json
  end

end
