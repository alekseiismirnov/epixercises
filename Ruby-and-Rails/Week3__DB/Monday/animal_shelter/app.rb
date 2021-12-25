# frozen_string_literal: true

require 'pg'
require 'pry'
require 'sinatra'
require 'sinatra/reloader'

also_reload 'lib/**/*.rb'

DB = PG.connect(dbname: 'animal_shelter')

get '/animals/new' do
  @table = Animal.table
  @fields = Animal.columns + %i[type breed]

  erb :'storable/add'
end

post '/animals' do
  type_id = params['type'].to_i
  breed_id = params['breed'].to_i

  animal = Animal.new params
  animal.save

  animal.add_related(Breed.find(breed_id))
  animal.add_related(Type.find(type_id))

  'stub'
end

get '/customers/new' do
  @table = Customer.table
  @fields = Customer.columns + %i[type breed]

  erb :'storable/add'
end

post '/customers' do
  type_id = params['type'].to_i
  breed_id = params['breed'].to_i

  customer = Customer.new params
  customer.save

  customer.add_related(Breed.find(breed_id))
  customer.add_related(Type.find(type_id))

  'stub'
end

get '/types/:id/animals' do
  id = params[:id].to_i

  type = Type.find id

  @items = type.animals.map(&:name).sort

  @title = type.name.en.plural.capitalize
  @list_class = 'animals_list'
  @item_class = 'animal'

  erb :simple_list
end

get '/breeds/:id/animals' do
  id = params[:id].to_i

  breed = Breed.find id

  @items = breed.animals.map(&:name).sort

  @title = breed.name.en.plural.capitalize
  @list_class = 'animals_list'
  @item_class = 'animal'

  erb :simple_list
end