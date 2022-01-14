# frozen_string_literal: true

require 'pg'
require 'pry'
require 'sinatra'
require 'sinatra/reloader'

also_reload 'lib/**/*.rb'

require_relative 'lib/train'

DB = PG.connect(dbname: 'animal_shelter')

get '/trains/:id/edit' do
  @table = Train.table
  @fields = Train.columns

  @id = params[:id].to_i
  train = Train.find @id
  @record = {
    number: train.number
  } # procedure could be moved to the Storable perhaps

  erb :'storable/update'
end

patch '/trains/:id' do
  id = params[:id].to_i
  train = Train.find id
  train.update(params)

  redirect request.path_info
end

get '/trains/new' do
  @table = Train.table
  @fields = Train.columns

  erb :'storable/add'
end

get '/trains/:id' do
  id = params[:id].to_i

  train = Train.find id
  @title = "Train #{train.number}"

  erb :object
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
  train = Train.new params
  train.save

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
  id = params[:id].to_i

  city = City.find id
  @title = city.name

  erb :object
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
  item = Train.find params[:id].to_i
  item.delete

  redirect '/trains'
end

delete '/cities/:id' do
  item = City.find params[:id].to_i
  item.delete

  redirect '/cities'
end


