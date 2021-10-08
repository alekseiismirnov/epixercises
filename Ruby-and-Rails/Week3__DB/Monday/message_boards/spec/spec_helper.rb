# frozen_string_literal: true

require 'rspec'
require 'pg'
require 'pry'
require './app'
require 'capybara/rspec'
require 'sinatra'

require 'board'
require 'message'

DB = PG.connect(dbname: 'message_boards_test')

RSpec.configure do |config|
  config.after(:each) do
  end
end
