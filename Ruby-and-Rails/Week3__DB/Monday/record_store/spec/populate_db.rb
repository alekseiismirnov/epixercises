# frozen_string_literal: true

require 'artist'
require 'album'

class AllArtistsAllAlbums
  attr_reader :artists_number, :albums_number

  def initialize(params)
    @artists_number = params[:artists_number] || 10
    @albums_number = params[:albums_number] || 5

    make_albums(@albums_number)
    make_artists(@artists_number)

    Artist.all.each do |artist|
      Album.all.each do |album|
        artist.update(album_name: album.name)
      end
    end
  end

  def make_albums(number)
    (1..number).each do |j|
      Album.new(name: "Album ##{j}").save
    end
  end

  def make_artists(number)
    (1..number).each do |i|
      Artist.new(name: "Artist ##{i}").save
    end
  end
end
