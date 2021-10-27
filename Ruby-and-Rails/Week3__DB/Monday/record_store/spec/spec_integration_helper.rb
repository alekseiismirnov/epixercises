require 'capybara/rspec'
require 'sinatra'

Capybara.app = Sinatra::Application

Capybara.save_path = '~/tmp'
