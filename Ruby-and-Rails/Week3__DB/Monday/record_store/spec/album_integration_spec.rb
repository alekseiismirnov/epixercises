# frozen_string_literal: true

require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('create an album path', type: :feature) do
  it('creates an album and then goes to the album page') do
    visit('/albums')
    click_on('Add a new album')
    fill_in('album_name', with: 'Yellow Submarine')
    click_on('Go')
    expect(page).to have_content('Yellow Submarine')
  end
end

describe('create a song path', type: :feature) do
  it('creates an album and goes to the album page') do
    album = Album.new('Yellow dwarf')
    album.save
    visit("/albums/#{album.id}")
    fill_in('song_name', with: 'Too small')
    click_on('Add')
    expect(page).to have_content('Too small')
  end
end
