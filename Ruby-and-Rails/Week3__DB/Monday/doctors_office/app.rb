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

get '/patients/new' do
  @table = Patient.table
  @fields = Patient.columns
  erb :'storable/add'
end

post '/patients' do
  name = params[:name]
  birthdate = params[:birthdate]
  Patient.new(name: name, birthdate: birthdate).save
  'stub'
end