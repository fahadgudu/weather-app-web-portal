class Places

  def initialize(lat, lng, type = "department_store",api_key = GOOGLE_API_KEY)
    @api_key = api_key
    @lat     = lat
    @lng     = lng
    @type    = type
  end

  def search(radius = 1000)
    path      = "/nearbysearch/json"
    options   = {key: @api_key, location: "#{@lat},#{@lng}", types: @type,radius: radius}
    url       = URI [PLACES_BASE_URL, path].join
    url.query = options.to_param
    Rails.logger.info "Initializing request ...."
    Rails.logger.info CGI.unescape(url)
    response  = HTTParty.get(url.to_s)
    results   = response["results"].select do |result|
      result["scope"] == "APP"
    end
    results.collect{|r| r["place_id"] }
  end

  def add!(name, address, phone)
    path = "/add/json?key=#{@api_key}"
    HTTParty.post([PLACES_BASE_URL, path].join, body: { location: { lat: @lat,lng: @lng }, accuracy: 50,name: name, address: address, types: ["department_store"], language: "en-AU" }.to_json)
  end

end
