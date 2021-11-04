require './app.rb'
require_relative './spec_helper.rb' 

require 'capybara/rspec'
require 'sinatra'

Capybara.app = Sinatra::Application

describe('Edit album', type: :feature) do
  before :each do
    (1..5).each do |j|
      album = Album.new(name: "Album ##{j}")
      album.save
    end

    (1..10).each do |i|
      artist = Artist.new(name: "Artist ##{i}")
      artist.save
      (1..5).each do |j|
        album = Album.new(name: "Album ##{j}")
        artist.update(album_name: album.name)
      end
    end

    Album.all.each do |album|
      (1..6).each do |i|
        name = "#{album.name}-Mamba number #{i}"
        Song.new(name: name, album_id: album.id).save
      end
    end
  end

  it 'allows to change album title' do
    title = 'Album #2'
    updated_title = 'Completely Different'

    visit '/albums'
    click_on title
    expect(page.status_code).to eq 200

    click_on 'Edit album'
    expect(page.status_code).to eq 200

    find_field('Rename album', with: title).set(updated_title)
    click_button 'Update!'

    expect(page.status_code).to eq 200
    expect(page).to have_content updated_title
    expect(page).to have_no_content title
  end
end
