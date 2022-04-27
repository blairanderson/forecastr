require 'sinatra'
require 'json'

get '/' do
  "Hello from Sinatra on Heroku!"
end


get '/forecast' do
  content_type :json
  { song: "Wake me Up" }.to_json
end
