require 'rspec'
require 'pry'
require 'album'
require 'song'

describe '#Song' do
  before :each do
    Album.clear()
    Song.clear()
    @album = Album.new('Giant Steps', nil)
    @album.save()
  end

  describe '#==' do
    it('is the same song if it has the same attributes as another song') do
      song = Song.new('Naima', @album.id, nil)
      song2 = Song.new('Naima', @album.id, nil)
      expect(song).to(eq(song2))
    end

    it('Songs with different albums id are not same') do
      song = Song.new('Naima', @album.id, nil)
      song2 = Song.new('Naima', 100500, nil)
      expect(song == song2).to eq(false)
    end
  end

  describe('.all') do
    it('returns a list of all songs') do
      song = Song.new('Giant Steps', @album.id, nil)
      song.save()
      song2 = Song.new('Naima', @album.id, nil)
      song2.save()
      expect(Song.all).to(eq([song, song2]))
    end
  end

  describe('.clear') do
    it('clears all songs') do
      song = Song.new('Giant Steps', @album.id, nil)
      song.save()
      song2 = Song.new('Naima', @album.id, nil)
      song2.save()
      Song.clear()
      expect(Song.all).to(eq([]))
    end
  end

  describe('#save') do
    it('saves a song') do
      song = Song.new('Naima', @album.id, nil)
      song.save()
      expect(Song.all).to(eq([song]))
    end
  end

  describe('.find') do
    it('finds a song by id') do
      song = Song.new('Giant Steps', @album.id, nil)
      song.save()
      song2 = Song.new('Naima', @album.id, nil)
      song2.save()
      expect(Song.find(song.id)).to(eq(song))
    end
  end

  describe('#update') do
    it('updates an song by id') do
      song = Song.new('Naima', @album.id, nil)
      song.save()
      song.update('Mr. P.C.', @album.id)
      expect(song.name).to(eq('Mr. P.C.'))
    end
  end

  describe('#delete') do
    it('deletes an song by id') do
      song = Song.new('Giant Steps', @album.id, nil)
      song.save()
      song2 = Song.new('Naima', @album.id, nil)
      song2.save()
      song.delete()
      expect(Song.all).to(eq([song2]))
    end
  end

  describe('.find_by_album') do
    it('finds songs for an album') do
      album2 = Album.new('Blue', nil)
      album2.save
      song = Song.new('Naima', @album.id, nil)
      song.save()
      song2 = Song.new('California', album2.id , nil)
      song2.save()
      expect(Song.find_by_album(album2.id)).to(eq([song2]))
    end
  end

  describe('#album') do
    it('finds the album a song belongs to') do
      song = Song.new('Naima', @album.id, nil)
      song.save()
      expect(song.album()).to(eq(@album))
    end
  end

  describe('#lyrics') do
    it 'is, actually' do
      song = Song.new('Naima', @album.id, nil)
      expect(song.respond_to?(:lyrics)).to eq(true)
    end
  end

  describe('#lyrics') do
    it 'is nil on initial' do
      song = Song.new('Naima', @album.id, nil)
      expect(song.lyrics).to eq(nil)  
    end
  end

  describe('#add_lyrics') do
    it 'adds some lyrics to the song' do
      lyrics = 'Souvent, je mens \nPour aussi papillonner'
      song = Song.new('Naima', @album.id, nil)
      song.add_lyrics(lyrics)
      expect(song.add_lyrics(lyrics)).to eq(lyrics)
    end

    it 'adds some lyrics to the song' do
      lyrics = 'Souvent, je mens \nPour aussi papillonner'
      song = Song.new('Naima', @album.id, nil)
      song.add_lyrics(lyrics)
      song.save
      same_song = Song.find(song.id)
      expect(same_song.lyrics).to eq(lyrics)
    end
  end
end
