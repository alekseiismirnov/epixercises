# frozen_string_literal: true

require_relative './spec_helper.rb'

describe('#delete') do
  before :each do
    @album = Album.new(name: 'A Love Supreme', id: nil)
    @album.save
    @song = Song.new(name: 'Naima', album_id: @album.id, id: nil)
    @song.save
    @artist_name = 'Kooshkineen Uurve'
    @artist = Artist.new(@artist_name)
    @artist.update(album_name: @album.name)

    @album.delete
  end

  it('deletes all songs belonging to a deleted album') do
    expect(Song.find(@song.id)).to eq(nil)
  end

  it 'deletes all association with artists' do

  end
end
