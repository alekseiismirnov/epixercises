# frozen_string_literal: true

require 'pg'
require 'pry'
require 'sinatra'
require 'sinatra/reloader'

require './lib/doctor.rb'

also_reload 'lib/**/*.rb'

DB = PG.connect(dbname: 'doctors_office')

get '/doctors/new' do
  @table = Doctor.table
  @fields = Doctor.columns
  erb :'storable/add'
end

post '/doctors' do
  name = params[:name]
  speciality = params[:speciality]
  Doctor.new(name: name, speciality: speciality).save
  'stub'
end