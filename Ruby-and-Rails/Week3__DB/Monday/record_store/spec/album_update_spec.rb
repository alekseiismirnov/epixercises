# frozen_string_literal: true

describe '#update' do
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

  it 'creates album-artists relations' do
    Album.all.each do |album|
      expect(album.artists).to match_array Artist.all
    end
  end

  it 'creates artist-albums relations' do
    Artist.all.each do |artist|
      expect(artist.albums).to match_array Album.all
    end
  end
end
