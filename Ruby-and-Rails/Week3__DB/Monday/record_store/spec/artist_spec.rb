# frozen_string_literal: true

require_relative './spec_helper.rb'

describe Artist do
  before :each do
    @artist = Artist.new(name: 'John Coltrane', id: nil)
    @artist.save
    @album = Album.new(name: 'A Love Supreme', id: nil)
    @album.save
    @artist.update(album_name: 'A Love Supreme')
  end

  describe '#update' do
    it 'adds an album to an artist' do
      expect(@artist.albums).to eq [@album]
    end
  end

  describe '#delete' do
    before :each do
      @another_artist = Artist.new(name: 'Gorshok')
      @another_artist.save
      @another_album = Album.new(name: 'Korol i Shut')
      @another_album.save
      @another_artist.update(album_name: 'Korol i Shut')
    end

    it 'deletes artist and does not delete another artist' do
      @artist.delete
      expect(Artist.all).to match_array [@another_artist]
    end

    it 'deletes correspondent associations with albums' do
      @artist.delete
      expect(@album.artists).to eq []
      expect(@another_album.artists).to eq [@another_artist]
    end
  end

  describe '#clear' do
    before :each do
      (1..10).each do |i|
        artist = Artist.new(name: "Artist ##{i}")
        artist.save
        (1..5).each do |j|
          album = Album.new(name: "Album ##{j}")
          album.save
          artist.update(album_name: album.name)
        end
      end
    end

    it 'deletes all artists' do
      Artist.clear

      expect(Artist.all).to eq []
    end

    it 'deletes all associations with albums' do
      Artist.clear

      Album.all.each do |album|
        expect(album.artists).to eq []
      end
    end
  end

  describe '#find' do
    before :each do
      @artists = (1..20).map { |i| Artist.new(name: "Noname ##{i}") }
      @artists.each(&:save)
    end

    it 'finds artist by id' do
      @artists.each do |artist|
        expect(Artist.find(artist.id)).to eq artist
      end
    end
  end
end
