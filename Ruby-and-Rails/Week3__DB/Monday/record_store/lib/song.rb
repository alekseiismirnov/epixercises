require './lib/album.rb'

class Song
  attr_reader :name, :album_id, :id, :lyrics

  @@songs = {}
  @@total = 0

  def initialize(name, album_id, id)
    @name = name
    @album_id = album_id
    @id = id || @@total += 1
  end

  def self.clear
    @@songs = {}
  end

  def self.all
    @@songs.values
  end

  def self.find(id)
    @@songs[id]
  end

  def self.find_by_album(album_id)
    @@songs.values.select { |song| song.album_id == album_id}
  end

  def ==(other)
    @name == other.name && @album_id == other.album_id
  end

  def save
    @@songs[id] = Song.new(@name, @album_id, @id)
    @@songs[id].add_lyrics @lyrics
  end

  def update(name, album_id)
    @name = name
    @album_id = album_id
    save
  end

  def delete
    @@songs.delete id
  end

  def album
    Album.find @album_id
  end

  def add_lyrics(lyrics)
    @lyrics = lyrics
  end
end
