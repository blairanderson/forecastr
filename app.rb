require 'sinatra'
require 'json'
require 'prophet'

get '/' do
  return "Hello from Sinatra on Heroku!"
end


post '/forecast' do
  content_type(:json)
  payload = JSON.parse(request.body.read, symbolize_names: true)

  return Prophet.forecast(payload[:data], count: payload[:count]).to_json
end
