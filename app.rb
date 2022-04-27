require 'sinatra'
require 'json'
require 'prophet'
require 'date'

get '/' do
  docs = <<-HEREDOC
// first get a series of data that you want to forecast
series = Orders.group_by_day(:created_at).sum("quantity_shipped")
// it should look like
// series = {
//   Date.parse("2020-01-01") => 100,
//   Date.parse("2020-01-02") => 150,
//   Date.parse("2020-01-03") => 100,
//   Date.parse("2020-01-04") => 136,
//   Date.parse("2020-01-05") => 138,
//   Date.parse("2020-01-06") => 139,
//   Date.parse("2020-01-07") => 150,
//   Date.parse("2020-01-08") => 166,
//   Date.parse("2020-01-09") => 176,
//   Date.parse("2020-01-10") => 186,
//   Date.parse("2020-01-11") => 199,
// }

// Then POST it.
uri = URI("https://forecast.shipmentbot.com/forecast")
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
request = Net::HTTP::Post.new(uri.path, {'Content-Type' => 'application/json'})
request.body = {
    'data' => data.as_json,
    'count' => 100
}.to_json
response = http.request(request).body
HEREDOC

return erb("
<!doctype html>
<html>
<head>
<meta charset='utf-8'>
<title>ShipmentBot Forecasting</title>
<link href='https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css' rel='stylesheet' integrity='sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3' crossorigin='anonymous'>
</head>
<body>
<main class='container'>
  <h1>Hello from ShipmentBot Forecasting!</h1>
  <p>Try this Code:</p>
  <pre>
  <code>
  #{docs}
  </code>
  </pre>
</main>
</body>
</html>")
end


post '/forecast' do
  content_type(:json)
  payload = JSON.parse(request.body.read)

  data = payload['data'].transform_keys do |key|
    Date.parse(key)
  end

  return Prophet.forecast(data, count: payload['count'].to_i).to_json
end
