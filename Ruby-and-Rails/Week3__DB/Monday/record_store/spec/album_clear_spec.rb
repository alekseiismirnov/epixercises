# frozen_string_literal: true

require_relative './spec_helper.rb'

describe '.clear' do
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
  end

  it 'removes all Album istances' do
    Album.clear

    expect(Album.all).to eq []
  end

  it 'removes all album-artist relations' do
    Album.clear

    Artist.all.each do |artist|
      expect(artist.albums).to eq []
    end
  end
end
