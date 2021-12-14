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

get '/patient/:patient_id/assign_doctor' do
  @doctor_id = params[:doctor_id].to_i
  @patient_id = params[:patient_id].to_i
  @input_name = 'doctor_id'
  @label = 'Doctor ID:'
  @action = "/patient/#{@patient_id}/assign_doctor"

  erb :'related/add'
end

patch '/patient/:patient_id/assign_doctor' do
  doctor_id = params[:doctor_id].to_i
  patient_id = params[:patient_id].to_i

  doctor = Doctor.find doctor_id
  patient = Patient.find patient_id

  doctor.add_related patient

  'stub'
end

get '/doctors/:id/patients' do
  id = params[:id].to_i
  doctor = Doctor.find id

  @items = doctor.patients.map(&:name)
  @title = "Doctor #{doctor.name} patients"
  @list_class = 'patients_list'
  @item_class = 'patient'

  erb :simple_list
end

get '/specialities' do
  @title = 'Select a speciality to add a new doctor'
  @list_class = 'specialities_list'
  @item_class = 'speciality'
  @link_to = '/specialities/%<id>s'
  @items = Speciality.all.map do |speciality|
    {
      'id' => speciality.id,
      'text' => speciality.speciality
    }
  end

  erb :linked_list
end

get '/specialities/:id' do
  id = params[:id].to_i
  speciality = Speciality.find id

  @title = speciality.speciality

  # simple_list
  @items = speciality.doctors.map(&:name)
  @list_class = 'doctors_list'
  @item_class = 'doctor'

  # general_post
  @table = Doctor.table
  @fields = Doctor.columns
  @action = "/specialities/#{id}/doctor"

  # simple_list + general_post:
  erb :speciality
end

post '/specialities/:id/doctor' do
  id = params[:id].to_i
  doctor_name = params[:name]
  doctor = Doctor.new(name: doctor_name)
  doctor.save

  speciality = Speciality.find id
  speciality.add_related doctor

  'stub'
end
