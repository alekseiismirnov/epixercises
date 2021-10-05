# frozen_string_literal: true

require 'rspec'
require 'pry'
require 'album'
require 'song'

describe('#delete') do
  it("deletes all songs belonging to a deleted album") do
    album = Album.new({:name => "A Love Supreme", :id => nil})
    album.save()
    song = Song.new({:name => "Naima", :album_id => album.id, :id => nil})
    song.save()
    album.delete()
    expect(Song.find(song.id)).to(eq(nil))
  end
end