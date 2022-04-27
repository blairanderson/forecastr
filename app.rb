require 'sinatra'
require 'json'

get '/' do
  return "Hello from Sinatra on Heroku!"
end


post '/forecast' do
  content_type(:json)
  payload = JSON.parse(request.body.read).symbolize_keys

  return Prophet.forecast(payload[:data], payload[:options]).to_json
end
