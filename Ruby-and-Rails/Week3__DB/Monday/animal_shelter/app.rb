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

get '/animals/sort_by_admittance' do
  @items = Animal
           .all
           .sort { |this, another| another.admittance <=> this.admittance }
           .map(&:name)

  @title = 'Animals, sorted by the admittance date'
  @list_class = 'animals_list'
  @item_class = 'animal'

  erb :simple_list
end

get '/animals/sort_by_name' do
  @items = Animal.all.map(&:name).sort

  @title = 'Animals'
  @list_class = 'animals_list'
  @item_class = 'animal'

  erb :simple_list
end

get '/breeds/:id/customers' do
  id = params[:id].to_i
  breed = Breed.find id

  @items = breed.customers.map(&:name)

  @title = "Customers who look for #{breed.name}"
  @list_class = 'customers_list'
  @item_class = 'customer'

  erb :simple_list
end