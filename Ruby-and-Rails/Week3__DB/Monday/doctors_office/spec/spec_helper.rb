# frozen_string_literal: true

require 'rspec'
require 'pg'
require 'pry'

require 'capybara/rspec'
require 'sinatra'

require 'storable'
require 'related'

require 'doctor'
require 'patient'

# Shared code for clearing tests between runs and connecting to the DB will also go here

DB = PG.connect(dbname: 'doctors_office_test')

RSpec.configure do |config|
  config.after(:each) do
    DB.exec('DELETE FROM doctors *;')
    DB.exec('DELETE FROM patients *;')
    DB.exec('DELETE FROM doctors_patients *;')
  end
end
