class Notifier

  APP_ID  = "0Ql6K7nYum1iI7yOzz3ORYvR2W23V8aJ4n9nnWJJ"
  API_KEY = "Ys0Az18ukubVt8JYhopq2ECOueX02cpYmMdcMD1g"

  def initialize(device)
    @device = device
    @connection = Faraday.new(:url => 'https://api.parse.com') do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
  end

  def notify(message, options = {})
    @connection.post do |req|
      req.url '/1/push'
      req.headers['Content-Type'] = 'application/json'
      req.headers['X-Parse-Application-Id'] = APP_ID
      req.headers['X-Parse-REST-API-Key'] = API_KEY
      req.body = data(message, options).to_json
    end
  end

  def data(message, options)
    body = {alert: message}.merge! options
    { where: {deviceToken: channel}, data: body }
  end

  def channel
    @device.token
  end

end
