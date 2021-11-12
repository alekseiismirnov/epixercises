# frozen_string_literal: true

require 'pg'
require 'pry'
require 'sinatra'
require 'sinatra/reloader'

require './lib/album.rb'
require './lib/song.rb'
require './lib/artist.rb'

also_reload 'lib/**/*.rb'

DB = PG.connect(dbname: 'record_store')

get '/' do
  redirect '/albums'
end

get '/albums' do
  @albums = Album.sort
  @albums_sold = Album.all_sold
  erb :albums
end

get '/albums/new' do
  erb :new_album
end

get '/albums/:id' do
  @album = Album.find(params[:id].to_i)
  halt 404 if @album.nil?

  @songs = @album.songs

  erb :album
end

post '/albums/:id/sell' do
  @album = Album.find(params[:id].to_i)
  @album.sold

  @albums = Album.all
  @albums_sold = Album.all_sold
  erb :albums
end

post '/albums' do
  name = params[:album_name]
  album = Album.new(name: name)
  album.save

  @albums = Album.all
  @albums_sold = Album.all_sold
  erb :albums
end

get '/albums/:id/edit' do
  @album = Album.find(params[:id].to_i)

  erb :edit_album
end

patch '/albums/:id' do
  @album = Album.find(params[:id].to_i)

  @album.update(name: params[:name])

  @albums = Album.all
  @albums_sold = Album.all_sold
  erb :albums
end

delete '/albums/:id' do
  @album = Album.find(params[:id].to_i)
  @album.delete

  @albums = Album.all
  @albums_sold = Album.all_sold
  erb :albums
end

post '/search' do
  @album = Album.search params[:album_name]
  if @album
    erb :album
  else
    erb :nothing_found
  end
end

get '/albums/:id/songs/:song_id' do
  @album = Album.find params[:id].to_i
  @song = Song.find params[:song_id].to_i

  erb :songs
end

post '/albums/:id/songs' do
  Song.new(name: params[:song_name], album_id: params[:id].to_i).save
  @album = Album.find params[:id].to_i
  @songs = @album.songs

  erb :album
end

patch '/albums/:id/songs/:song_id' do
  @song = Song.find params[:song_id].to_i
  @song.update(params[:song_name], params[:id].to_i)

  @album = Album.find params[:id].to_i
  @songs = @album.songs

  erb :album
end

delete '/albums/:id/songs/:song_id' do
  song = Song.find params[:song_id].to_i
  song.delete

  @album = Album.find params[:id].to_i
  @songs = @album.songs
  erb :album
end

get '/artists' do
  @artists = Artist.all.map(&:to_json)

  erb :artists
end

get '/artists/new' do
  erb :new_artist
end

get '/artists/:id' do
  artist = Artist.find(params[:id].to_i)

  @artist = artist.to_json
  @albums = artist.albums.map(&:to_json)

  erb :artist
end

post '/artists' do
  Artist.new(name: params[:artists_name])
        .save

  redirect '/artists'
end

patch '/artists/:id' do
  Artist.find(params[:id].to_i)
        .update(name: params[:artists_name])

  redirect '/artists'
end

delete '/artists/:id' do
  Artist.find(params[:id].to_i)
        .delete

  redirect '/artists'
end

patch '/artists/:id/add_album' do
  id = params[:id].to_i
  album_name = params[:album_name]

  artist = Artist.find id
  artist.update(album_name: album_name)

  redirect "/artists/#{id}"
end
