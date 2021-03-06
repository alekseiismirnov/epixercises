# frozen_string_literal: true

require_relative './spec_helper.rb'

describe '#Song' do
  before :each do
    Album.clear
    Song.clear
    @album = Album.new(name: 'Giant Steps')
    @album.save
  end

  describe '#==' do
    it('is the same song if it has the same attributes as another song') do
      song = Song.new(name: 'Naima',album_id: @album.id)
      song2 = Song.new(name: 'Naima', album_id: @album.id)
      expect(song).to(eq(song2))
    end

    it('Songs with different albums id are not same') do
      song = Song.new(name: 'Naima', album_id: @album.id)
      song2 = Song.new(name: 'Naima', album_id: 100_500)
      expect(song == song2).to eq(false)
    end
  end

  describe('.all') do
    it('returns a list of all songs') do
      song = Song.new(name: 'Giant Steps', album_id: @album.id)
      song.save
      song2 = Song.new(name: 'Naima', album_id: @album.id)
      song2.save
      expect(Song.all).to(eq([song, song2]))
    end
  end

  describe('.clear') do
    it('clears all songs') do
      song = Song.new(name: 'Giant Steps', album_id: @album.id)
      song.save
      song2 = Song.new(name: 'Naima', album_id: @album.id)
      song2.save
      Song.clear
      expect(Song.all).to(eq([]))
    end
  end

  describe('#save') do
    it('saves a song') do
      song = Song.new(name: 'Naima', album_id: @album.id)
      song.save
      expect(Song.all).to(eq([song]))
    end
  end

  describe('.find') do
    it('finds a song by id') do
      song = Song.new(name: 'Giant Steps', album_id: @album.id)
      song.save
      song2 = Song.new(name: 'Naima', album_id: @album.id)
      song2.save
      expect(Song.find(song.id)).to(eq(song))
    end
  end

  describe('#update') do
    it('updates an song by id') do
      song = Song.new(name: 'Naima', album_id: @album.id)
      song.save
      song.update('Mr. P.C.', @album.id)
      expect(song.name).to(eq('Mr. P.C.'))
    end
  end

  describe('#delete') do
    it('deletes an song by id') do
      song = Song.new(name: 'Giant Steps', album_id: @album.id)
      song.save
      song2 = Song.new(name: 'Naima', album_id: @album.id)
      song2.save
      song.delete
      expect(Song.all).to(eq([song2]))
    end
  end

  describe('.find_by_album') do
    it('finds songs for an album') do
      album2 = Album.new(name: 'Blue')
      album2.save
      song = Song.new(name: 'Naima', album_id: @album.id)
      song.save
      song2 = Song.new(name: 'California', album_id: album2.id)
      song2.save
      expect(Song.find_by_album(album2.id)).to(eq([song2]))
    end
  end

  describe('#album') do
    it('finds the album a song belongs to') do
      song = Song.new(name: 'Naima', album_id: @album.id)
      song.save
      expect(song.album).to(eq(@album))
    end
  end

  describe('#lyrics') do
    it 'is, actually' do
      song = Song.new(name: 'Naima', album_id: @album.id)
      expect(song.respond_to?(:lyrics)).to eq(true)
    end
  end

  describe('#lyrics') do
    it 'is nil on initial' do
      song = Song.new(name:'Naima', album_id: @album.id)
      expect(song.lyrics).to eq(nil)
    end
  end

  describe('#add_lyrics') do
    it 'adds some lyrics to the song' do
      lyrics = 'Souvent, je mens \nPour aussi papillonner'
      song = Song.new(name: 'Naima', album_id: @album.id)
      song.add_lyrics(lyrics)
      song.save

      same_song = Song.find(song.id)
      expect(same_song.lyrics).to eq(lyrics)
    end
  end
end
