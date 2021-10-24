# frozen_string_literal: true

# Identical to the Album class
class Artist
  attr_reader :id, :name

  def initialize(params)
    @name = params[:name]
    @id ||= params[:id]
  end

  def self.all
    DB.exec('SELECT * FROM artists;')
      .map { |record| new(to_my_params(record)) }
  end

  def self.to_my_params(record)
    {
      id: record['id'].to_i,
      name: record['name']
    }
  end

  def self.clear
    DB.exec('DELETE FROM artists *;')
    DB.exec('DELETE FROM albums_artists *;') # no artists no relations
  end

  def self.find(id)
    DB.exec("SELECT * FROM ARTISTS WHERE id = #{id};")
      .map { |record| new(to_my_params(record)) }
      .first
  end

  def save
    report = DB.exec "INSERT INTO artists (name) VALUES ('#{@name}') RETURNING id;"
    @id = report.first['id'].to_i
  end

  def update(params)
    update_name(params[:name])
    add_album(params[:album_name])
  end

  def albums
    DB.exec("SELECT id_album FROM albums_artists WHERE id_artist = #{@id};")
      .map { |record| DB.exec("SELECT * FROM albums WHERE id = #{record['id_album'].to_i};") }
      .map { |result| Album.new(Album.to_my_params(result.first)) }
  end

  def delete
    DB.exec("DELETE FROM albums_artists WHERE id_artist = #{@id};")
    DB.exec("DELETE FROM artists WHERE id = #{@id};")
  end

  def ==(other)
    name == other.name
  end

  private

  def update_name(new_name)
    unless new_name.nil?
      @name = new_name
      DB.exec "UPDATE artists SET name = '#{@name}' WHERE id = #{@id};"
    end
  end

  def add_album(album_name)
    unless album_name.nil?
      album_id = DB.exec("SELECT id FROM albums WHERE name = '#{album_name}';")
                   .first['id'].to_i
      DB.exec "INSERT INTO albums_artists (id_album, id_artist) VALUES (#{album_id}, #{id});"
    end
  end
end
