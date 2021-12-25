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

class SnakePot
  def initialize
    @types = %w[dog bird frog].map { |type| [type, Type.new(name: type)] }.to_h
    @types.values.each(&:save)

    @breeds = %w[homefly crow corgi].map { |breed| [breed, Breed.new(name: breed)] }.to_h
    @breeds.values.each(&:save)

    @type_fly = Type.new(name: 'fly')
    @type_fly.save

    @breed_homefly = Breed.new(name: 'homefly')
    @breed_homefly.save

    @type_snake = Type.new(name: 'snake')
    @type_snake.save

    @breed_cobra = Breed.new(name: 'cobra')
    @breed_cobra.save

    @breed_boa = Breed.new(name: 'boa')
    @breed_boa.save

    @snakes_data = [
      { name: 'Cherry', gender: 'M', admittance: '1 Jan 2020', type: @type_snake, breed: @breed_cobra },
      { name: 'Giselle', gender: 'M', admittance: '2 Oct 2015', type: @type_snake, breed: @breed_boa },
      { name: 'Storm', gender: 'F', admittance: '10 May 2019', type: @type_snake, breed: @breed_cobra },
      { name: 'Pearl', gender: 'M', admittance: '14Jun 2017', type: @type_snake, breed: @breed_boa },
      { name: 'Venus', gender: 'F', admittance: '3 Feb 2018', type: @type_snake, breed: @breed_cobra },
      { name: 'Mango', gender: 'F', admittance: '3 Mar 2014', type: @type_snake, breed: @breed_boa }
    ]

    @snakes_data.each do |record|
      animal = Animal.new(record)
      animal.save
      animal.add_related(record[:type])
      animal.add_related(record[:breed])
    end

    @flies_data = [
      { name: 'Cinarya', gender: 'F', admittance: '10 Jul 2018', type: @type_fly, breed: @breed_homefly },
      { name: 'Saelinihle', gender: 'F', admittance: '22 Aug 2018', type: @type_fly, breed: @breed_homefly },
      { name: 'Minonden', gender: 'M', admittance: '1 Apr 2018', type: @type_fly, breed: @breed_homefly },
      { name: 'Thaorfhar', gender: 'M', admittance: '23 Jan 2019', type: @type_fly, breed: @breed_homefly },
      { name: 'Culssare', gender: 'F', admittance: '14 Feb 2018', type: @type_fly, breed: @breed_homefly },
      { name: 'Grayious', gender: 'M', admittance: '5 Oct 2018', type: @type_fly, breed: @breed_homefly }
    ]

    @customers_names = [
      'Groggeath Grumbleshaper',
      'Jokdraed Drakebeard',
      'Vostret Merrybreaker',
      'Utmorlum Treasuretank',
      'Umikkumi Chaosbeard',
      'Yovuth Goldenmantle',
      'Grobroc Lightstone',
      'Lorgaec Iceborn',
      'Glammatin Ashmane',
      'Hanmerlum Fierybelt'
    ]

    @customers_phones = %w[
      202-555-0199
      202-555-0132
      202-555-0194
      202-555-0135
      202-555-0192
      202-555-0110
      202-555-0187
      202-555-0166
      202-555-0140
      202-555-0177
    ]

    @customers_names.zip(@customers_phones)[0, 5].each do |name, phone|
      customer = Customer.new(name: name, phone: phone)
      customer.save

      breed = @breed_homefly
      breed.add_related customer
    end

    @customers_names.zip(@customers_phones)[5, 5].each do |name, phone|
      customer = Customer.new(name: name, phone: phone)
      customer.save

      breed = @breed_boa
      breed.add_related customer
    end

    @flies_data.each do |record|
      animal = Animal.new(record)
      animal.save
      animal.add_related(record[:type])
      animal.add_related(record[:breed])
    end

    @cobras_names = %w[Cherry Storm Venus]
    @boas_names = %w[Pearl Giselle Mango]
    @fly_names = %w[Cinarya Saelinihle Minonden Thaorfhar Culssare Grayious]
    @birds_names = %w[Fido]
  end
end
