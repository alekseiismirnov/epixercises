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
