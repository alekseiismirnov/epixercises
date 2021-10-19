# frozen_string_literal: true

require_relative './spec_helper.rb'

describe Artist do
  before :each do
    @artist = Artist.new(name: 'John Coltrane', id: nil)
    @artist.save
    @album = Album.new(name: 'A Love Supreme', id: nil)
    @album.save
    @artist.update(album_name: 'A Love Supreme')
  end

  describe '#update' do
    it 'adds an album to an artist' do
      expect(@artist.albums).to eq [@album]
    end
  end

  describe '#delete' do
    before :each do
      @another_artist = Artist.new(name: 'Gorshok')
      @another_artist.save
      @another_album = Album.new(name: 'Korol i Shut')
      @another_album.save
      @another_artist.update(album_name: 'Korol i Shut')
    end

    it 'deletes artist and does not delete another artist' do
      @artist.delete
      expect(Artist.all).to match_array [@another_artist]
    end
  end
end

