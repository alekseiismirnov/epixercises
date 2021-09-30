# frozen_string_literal: true

require 'pry'
require 'sinatra'
require 'sinatra/reloader'

require './lib/album.rb'
require './lib/song.rb'

also_reload 'lib/**/*.rb'

get '/' do
  @albums = Album.sort
  @albums_sold = Album.all_sold
  erb :albums
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
  album = Album.new(name, nil)
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
  @album.update(params[:name])

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
  Song.new(params[:song_name], params[:id].to_i, nil).save
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
