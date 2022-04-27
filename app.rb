require 'sinatra'
require 'json'
require 'prophet'
require 'date'

get '/' do
  return "Hello from Sinatra on Heroku!"
end


post '/forecast' do
  content_type(:json)
  payload = JSON.parse(request.body.read)

  data = payload['data'].transform_keys do |key|
    Date.parse(key)
  end

  return Prophet.forecast(data, count: payload['count'].to_i).to_json
end
