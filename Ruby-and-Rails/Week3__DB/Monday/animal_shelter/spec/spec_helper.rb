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

# Shared code for clearing tests between runs and connecting to the DB will also go here

DB = PG.connect(dbname: 'doctors_office_test')

RSpec.configure do |config|
  config.after(:each) do

    DB.exec('DELETE FROM mocktors *;')
    DB.exec('DELETE FROM faketients *;')
    DB.exec('DELETE FROM faketients_mocktors *;')
  end
end

Capybara.app = Sinatra::Application

Capybara.save_path = '~/tmp'
