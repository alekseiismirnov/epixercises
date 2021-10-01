# frozen_string_literal: true

class Album
  attr_reader :name, :id

  def initialize(attributes)
    @name = attributes[:name]
    @id = attrubutes[:id]
  end

  def self.all
    DB.exec('SELECT * FROM albums;').map do |record|
      Album.new(record[:id], record[:name])
    end
  end

  def self.clear
    DB.exec('DELETE FROM albums *;')
  end

  def self.find(id)
    record = DB.exec("SELECT * FROM albums WHERE id = #{id};")
    Album.new(id: record[:id], name: record[:name])
  end

  def self.search(name)
    Album.all.find { |album| album.name == name }
  end

  def self.sort
    Album.all.sort { |album, album2| album.name <=> album2.name }
  end

  def self.all_sold
    @@albums_sold.values
  end

  def save
    report = DB.exec("INSERT INTO albums (name) VALUES('#{@name}') RETURNING id;")
    @id = report[:id].to_i
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
  end

  def sold
    @@albums.delete id
    @@albums_sold[id] = self
  end

  def songs
    Song.find_by_album id
  end
end
