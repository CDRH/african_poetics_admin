class Elasticsearch

  def initialize
    @category = ES_RAKE_SETTINGS["category"]
    @collection = ES_RAKE_SETTINGS["collection"]
    @es_index = ES_RAKE_SETTINGS["index"]
    @es_path = ES_RAKE_SETTINGS["path"]
  end

  def clear()
    path = File.join(@es_path, @es_index, "_doc/_delete_by_query?pretty=true")
    query = {
      "query" => {
        "bool" => {
          "must" => [
            {
              "term" => {
                "collection" => @collection
              }
            },
            {
              "term" => {
                "category" => @category
              }
            }
          ]
        }
      }
    }
    post(path, query, ok_msg: true)
  end

  def post_document(data)
    path = File.join(@es_path, @es_index, "_doc", data["identifier"])
    post(path, data)
  end

  private

  # do not need to send confirmation for majority of posting
  def handle_res(res, ok_msg: false)
    if res.code != "200" && res.code != "201"
      puts "OH NO #{res.code}: #{res.read_body}"
    elsif ok_msg
      puts "success! #{res.code}: #{res.read_body}"
    end
  end

  def post(url, data, ok_msg: false)
    uri = URI(url)

    puts "posting to #{url}"

    begin
      req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
      req.body = data.to_json
      res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == "https") do |http|
        http.request(req)
      end
      handle_res(res, ok_msg: ok_msg)
    rescue => e
      puts "there's been a problem #{e}"
    end
  end
end
