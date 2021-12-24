# frozen_string_literal: true

require 'rspec'
require 'pg'
require 'pry'

require './app'

require 'capybara/rspec'
require 'sinatra'

require 'storable'
require 'related'

require 'mocktor'
require 'faketient'

require 'animal'
require 'customer'
require 'breed'
require 'type'

# Shared code for clearing tests between runs and connecting to the DB will also go here

DB = PG.connect(dbname: 'animal_shelter_test')

RSpec.configure do |config|
  config.after(:each) do
    DB.exec('DELETE FROM animals *;')
    DB.exec('DELETE FROM customers *;')
    DB.exec('DELETE FROM breeds *;')
    DB.exec('DELETE FROM types *;')
    DB.exec('DELETE FROM animals_breeds *;')
    DB.exec('DELETE FROM customers_types *;')
    DB.exec('DELETE FROM animals_types *;')
    DB.exec('DELETE FROM breeds_customers *;')

    DB.exec('DELETE FROM mocktors *;')
    DB.exec('DELETE FROM faketients *;')
    DB.exec('DELETE FROM faketients_mocktors *;')
  end
end

Capybara.app = Sinatra::Application

Capybara.save_path = '~/tmp'

@types = %i[dog bird frog].map { |type| [type => Type.new(type)] }.to_h
@types.values.each(&:save)

@breeds = %i[homefly crow corgi].map { |breed| [type => Breed.new(breed)] }.to_h
@breeds.values.each(&:save)

@type_fly = Type.new(name: 'fly')
@type_fly.save

@breed_homefly = Breed.new(name: 'homefly')
@breed_homefly.save

@type_snake = Type.new(name: 'snake')
@type_snake.save

@cobra_breed = Breed.new(name: 'cobra')
@cobra_breed.save

@boa_breed = Breed.new(name: 'boa')
@boa_breed.save

@snakes_data = [
  { name: 'Cherry', gender: 'M', admittance: '1 Jan 2020', type: @type_snake, breed: @cobra_breed },
  { name: 'Giselle', gender: 'M', admittance: '2 Oct 2015', type: @type_snake, breed: @boa_breed },
  { name: 'Storm', gender: 'F', admittance: '10 May 2019', type: @type_snake, breed: @cobra_breed },
  { name: 'Pearl', gender: 'M', admittance: '14Jun 2017', type: @type_snake, breed: @boa_breed },
  { name: 'Venus', gender: 'F', admittance: '3 Feb 2018', type: @type_snake, breed: @cobra_breed },
  { name: 'Mango', gender: 'F', admittance: '3 Mar 2014', type: @type_snake, breed: @boa_breed }
]

@snakes_data.each do |record|
  animal = Animal.new(record)
  animal.add_related(params[:type])
  animal.add_related(params[:breed])
end

@flies_data = [
  { name: 'Cinarya', gender: 'F', admittance: '10 Jul 2018', type: @type_fly, breed: @breed_homefly },
  { name: 'Saelinihle', gender: 'F', admittance: '22 Aug 2018', type: @type_fly, breed: @breed_homefly },
  { name: 'Minonden', gender: 'M', admittance: '1 Apr 2018', type: @type_fly, breed: @breed_homefly },
  { name: 'Thaorfhar', gender: 'M', admittance: '23 Jan 2019', type: @type_fly, breed: @breed_homefly },
  { name: 'Culssare', gender: 'F', admittance: '14 Feb 2018', type: @type_fly, breed: @breed_homefly },
  { name: 'Grayious', gender: 'M', admittance: '5 Oct 2018', type: @type_fly, breed: @breed_homefly }
]

@flies_data.each do |record|
  animal = Animal.new(record)
  animal.add_related(params[:type])
  animal.add_related(params[:breed])
end

@cobra_names = %i[Cherry Storm Venus]
@boa_names = %i[Pearl Giselle Mango]
@fly_names = %i[Cinarya Saelinihle Minonden Thaorfhar Culssare Grayious]
@bird_names = %i[Fido]
