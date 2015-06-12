class Notifier

  APP_ID  = "0Ql6K7nYum1iI7yOzz3ORYvR2W23V8aJ4n9nnWJJ"
  API_KEY = "Ys0Az18ukubVt8JYhopq2ECOueX02cpYmMdcMD1g"

  def initialize(device)
    @device = device
  end

  def notify(message, options = {})
    Parse.init(:application_id  => APP_ID, :api_key => API_KEY)
    push = Parse::Push.new(data(message, options), channel)
    push.type = @device.device_type
    push.save
  end

  def data(message, options = {})
    {alert: message}.merge options
  end

  def channel
    @device.token
  end

end
