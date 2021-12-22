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
