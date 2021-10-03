# frozen_string_literal: true

require 'pg'

DB = PG.connect(dbname: 'record_store')

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
  end

  def self.find(id)
    record = DB.exec("SELECT * FROM albums WHERE id = #{id};").first
    Album.new(id: record['id'], name: record['name'])
  end

  def self.search(params)
    Album.all.find { |album| album.name == params[:name] }
  end

  def self.sort
    Album.all.sort { |album, album2| album.name <=> album2.name }
  end

  def self.all_sold
    DB.exec('SELECT * FROM albums WHERE sold = true;').map do |record|
      Album.new(id: record['id'], name: record['name'])
    end
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

  def update(name)
    @name = name
    DB.exec("UPDATE albums SET name = '#{name}' WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM albums WHERE id = #{@id};")
    DB.exec("DELETE FROM songs WHERE album_id = #{@id};")
  end

  def songs
    Song.find_by_album id
  end
end
