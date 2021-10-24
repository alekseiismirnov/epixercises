# frozen_string_literal: true

require 'pg'

class Album
  attr_reader :name, :id

  def initialize(attributes)
    @name = attributes[:name]
    @id = attributes[:id]
  end

  def self.all
    DB.exec('SELECT * FROM albums WHERE sold = false;').map do |record|
      Album.new(id: record['id'], name: record['name'])
    end
  end

  def self.clear
    DB.exec('DELETE FROM albums *;')
    DB.exec('DELETE FROM albums_artists *;')
  end

  def self.find(id)
    record = DB.exec("SELECT * FROM albums WHERE id = #{id};").first
    Album.new(id: record['id'], name: record['name']) unless record.nil?
  end

  def self.search(params)
    Album.all.find { |album| album.name == params[:name] }
  end

  def self.sort
    Album.all.sort { |album, album2| album.name <=> album2.name }
  end

  def self.all_sold
    DB.exec('SELECT * FROM albums WHERE sold = true;').map do |record|
      Album.new(id: record['id'].to_i, name: record['name'])
    end
  end

  def self.to_my_params(record)
    {
      id: record['id'].to_i,
      name: record['name']
    }
  end

  def sold
    DB.exec("UPDATE albums SET sold = true WHERE id = #{@id};")
  end

  def save
    report = DB.exec("INSERT INTO albums (name) VALUES('#{@name}') RETURNING id;")

    @id = report.first['id'].to_i
  end

  def ==(other)
    @name == other.name
  end

  def update(params)
    update_name(params[:name])
    add_artist(params[:artist_name])
  end

  def delete
    DB.exec("DELETE FROM albums_artists WHERE id_album = #{@id};")
    DB.exec("DELETE FROM songs WHERE album_id = #{@id};")
    DB.exec("DELETE FROM albums WHERE id = #{@id};")
  end

  def songs
    Song.find_by_album id
  end

  def artists
    DB.exec("SELECT id_artist FROM albums_artists WHERE id_album = #{@id};")
      .map { |record| record['id_artist'].to_i }
      .map { |artist_id| Artist.find(artist_id) }
  end

  private

  def update_name(name)
    unless name.nil?
      @name = name
      DB.exec("UPDATE albums SET name = '#{name}' WHERE id = #{@id};")
    end
  end

  def add_artist(artist_name)
    unless artist_name.nil?
      DB.exec("SELECT id FROM artists WHERE artist_name = #{artist_name};")
        .map { |result| DB.exec("INSERT INTO albums_artists (id_album, id_artist) VALUES (#{@id}, #{result['id']};") }
        .first
    end
  end
end
