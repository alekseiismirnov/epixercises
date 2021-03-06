# frozen_string_literal: true

require 'pg'
require 'pry'
require 'sinatra'
require 'sinatra/reloader'

also_reload 'lib/**/*.rb'

require_relative 'lib/train'
require_relative 'lib/city'
require_relative 'lib/stop'

DB = PG.connect(dbname: 'train_system')

get '/trains/:id/edit' do
  @id = params[:id].to_i
  train = Train.find @id
  @record = {
    number: train.number
  } # procedure could be moved to the Storable perhaps

  @cities = City.all.map do |city|
    {
      id: city.id,
      name: city.name
    }
  end

  erb :train_edit
end

patch '/trains/:id' do
  id = params[:id].to_i
  number = params[:number]

  city_id = params[:city_id]
  minutes = params[:minutes].to_i

  train = Train.find id
  train.update(number: number) unless number.empty?

  if city_id && minutes
    stop = Stop.new(minutes: minutes)
    stop.save
    stop.add_related(City.find(city_id))
    train.add_related(stop)
  end

  redirect request.path_info
end

get '/trains/new' do
  @table = Train.table
  @fields = Train.columns + [:stops]

  erb :'storable/add'
end

get '/trains/:id' do
  id = params[:id].to_i

  train = Train.find id
  @title = "Train #{train.number}"
  @timetable = train.stops.map do |stop|
    {
      city: stop.city.name,
      minutes: stop.minutes
    }
  end

  erb :train
end

get '/trains' do
  @title = 'Trains'
  @items = Train.all.map do |train|
    {
      id: train.id,
      text: train.number,
      url: "/trains/#{train.id}"
    }
  end
  @list_class = 'trains_list'
  @item_class = 'train'

  erb :trains
end

post '/trains' do
  stop_ids = params[:stops].split(', ').map(&:to_i)

  train = Train.new params
  train.save

  stop_ids.each do |stop_id|
    train.add_related(Stop.find(stop_id))
  end

  redirect '/trains'
end

get '/cities/new' do
  @table = City.table
  @fields = City.columns

  erb :'storable/add'
end

post '/cities' do
  city = City.new params
  city.save

  redirect '/cities'
end

get '/cities/:id/edit' do
  @table = City.table
  @fields = City.columns

  @id = params[:id].to_i
  city = City.find @id
  @record = {
    name: city.name
  } # procedure could be moved to the Storable perhaps

  erb :'storable/update'
end

patch '/cities/:id' do
  id = params[:id].to_i
  city = City.find id
  city.update(params)

  redirect request.path_info
end

get '/cities/:id' do
  @city_id = params[:id].to_i

  city = City.find @city_id
  @title = city.name
  @trains = city.stops.map(&:train).map do |train|
    {
      train_id: train.id,
      number: train.number
    }
  end

  erb :city
end

get '/cities' do
  @title = 'Cities'
  @items = City.all.map do |city|
    {
      id: city.id,
      text: city.name,
      url: "/cities/#{city.id}"
    }
  end
  @list_class = 'cities_list'
  @item_class = 'city'

  erb :cities
end

delete '/trains/:id' do
  train = Train.find params[:id].to_i
  train.delete

  redirect '/trains'
end

delete '/cities/:id' do
  city = City.find params[:id].to_i
  city.delete

  redirect '/cities'
end

post '/tickets' do
  city_id = params['city_id'].to_i
  train_id = params['train_id'].to_i

  @departure_date = Date.parse(params['departure_date']).strftime('%d %b %Y')

  @city = City.find(city_id).name
  @train = Train.find(train_id).number

  erb :ticket
end
