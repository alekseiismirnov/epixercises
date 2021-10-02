require './lib/album.rb'

class Song
  attr_reader :name, :album_id, :id, :lyrics

  def initialize(name, album_id, id)
    @name = name
    @album_id = album_id
    @id = id
  end

  def self.clear
    DB.exec('DELETE FROM songs *;')
  end

  def self.all
    DB.exec('SELECT * FROM songs;').map do |record|
      Song.new(record[:name], record[:album_id].to_i, record[:id].to_i)
    end
  end

  def self.find(id)
    DB.exec("SELECT * FROM songs WHERE id = #{id};").map do |record|
      Song.new(record[:name], record[:album_id].to_i, record[:id].to_i)
    end.first
  end

  def self.find_by_album(album_id)
    DB.exec("SELECT * FROM songs WHERE album_id = #{album_id};").map do |record|
      Song.new(record['name'], record['album_id'].to_i, record['id'].to_i)
    end
  end

  def ==(other)
    @name == other.name && @album_id == other.album_id
  end

  def save
    report = DB.exec("INSERT INTO songs (name, album_id) VALUES ('#{@name}', #{@album_id}) RETURNING id;")
    @id = report.first[:id].to_i
  end

  def update(name, album_id)
    @name = name
    @album_id = album_id
    DB.exec("UPDATE songs SET name = '#{name}, album_id = #{album_id} WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM songs WHERE id = #{@id};")
  end

  def album
    Album.find @album_id
  end

  def add_lyrics(lyrics)
    @lyrics = lyrics
  end
end
