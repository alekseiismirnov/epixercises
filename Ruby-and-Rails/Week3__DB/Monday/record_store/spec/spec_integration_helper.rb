require 'capybara/rspec'
require 'sinatra'
require './app.rb'

Capybara.app = Sinatra::Application
set(:show_exceptions, false)
