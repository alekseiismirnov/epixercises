# frozen_string_literal: true

require 'rspec'
require 'pg'
require 'pry'

require 'album'
require 'song'
require 'artist'

# Shared code for clearing tests between runs and connecting to the DB will also go here

DB = PG.connect(dbname: 'record_store_test')

RSpec.configure do |config|
  config.after(:each) do
    DB.exec('DELETE FROM albums *;')
    DB.exec('DELETE FROM songs *;')
    DB.exec('DELETE FROM artists *;')
    DB.exec('DELETE FROM albums_artists *;')
  end
end
