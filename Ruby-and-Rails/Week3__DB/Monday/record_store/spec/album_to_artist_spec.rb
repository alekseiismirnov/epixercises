# frozen_string_literal: true

require './app.rb'
require_relative './spec_helper.rb'

require 'capybara/rspec'
require 'sinatra'

Capybara.app = Sinatra::Application

describe('Add album to artist', type: :feature) do
  before :each do
    (1..6).each do |j|
      j = 22 if j >= 4

      album = Album.new(name: "Album ##{j}")
      album.save
    end

    (1..10).each do |i|
      artist = Artist.new(name: "Artist ##{i}")
      artist.save
    end
  end

  context 'by its name' do
    context 'add one of the existing album' do
      it 'one time' do
        5.times do
          artist = Artist.all[5]
          visit "/artists/#{artist.id}"

          within('.add_album') do
            fill_in 'album_name', with: 'Album #1'
            click_button 'Go!'
          end
        end

        within('.albums') do
          expect(all('.album').map(&:text)).to match_array ['Album #1']
        end
      end
    end

    it 'is add a name of non-existent album' do 
      artist = Artist.all[3]
      new_name = 'Album that does not exist'
      visit "/artists/#{artist.id}"

      within('.add_album') do
        fill_in 'album_name', with: new_name
        click_button 'Go!'
      end

      expect(Album.all.map(&:name).any?(new_name)).to eq true
    end

    it 'gives a list of id-album list in a case of non-unique name'
  end
end
