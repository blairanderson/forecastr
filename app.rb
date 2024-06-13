require 'sinatra'
require 'erb'
require 'json'
require 'prophet'
require 'date'
require 'pry'

get '/' do
  erb(:index, layout: :layout)
end

post '/test' do
  strptime = params[:strptime] || '%m/%d/%Y'
  count = params[:count].to_i || 10
  data = params[:series].split("\n")
  data.map! { |row| row.split("\t").map(&:strip) }
  series = {}
  data.each do |row|
    next if row[0].nil? || row[1].nil?
    date = Date.strptime(row[0], strptime)
    series[date] = row[1].delete(",$").to_f
  end

  min_date = series.keys.min
  max_date = series.keys.max
  (min_date..max_date).each do |date|
    series[date] ||= 0.0
  end

  forecast = Prophet.forecast(series, count: count).to_json
  erb(:test, locals: { series: series.transform_keys(&:to_s), forecast: forecast })
end

post '/forecast' do
  content_type(:json)
  payload = JSON.parse(request.body.read)

  series = payload['data'].transform_keys { |key| Date.parse(key) }

  return Prophet.forecast(series, count: payload['count'].to_i || 10).to_json
end
