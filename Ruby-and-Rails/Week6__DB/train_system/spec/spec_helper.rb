# frozen_string_literal: true

require 'rspec'
require 'pg'
require 'pry'

require 'capybara/rspec'
require 'sinatra'

require 'storable'
require 'related'

require 'faketient'
require 'mocktor'

require 'train'
require 'city'
require 'stop'

require 'color_lines'

# Shared code for clearing tests between runs and connecting to the DB will also go here

DB = PG.connect(dbname: 'train_system_test')

RSpec.configure do |config|
  config.after(:each) do
    DB.exec('DELETE FROM cities_stops *;')
    DB.exec('DELETE FROM stops_trains *;')
    DB.exec('DELETE FROM trains *;')
    DB.exec('DELETE FROM cities *;')
    DB.exec('DELETE FROM stops *;')

    DB.exec('DELETE FROM faketients_mocktors *;')
    DB.exec('DELETE FROM mocktors *;')
    DB.exec('DELETE FROM faketients *;')
  end
end

Capybara.app = Sinatra::Application

Capybara.save_path = '~/tmp'
