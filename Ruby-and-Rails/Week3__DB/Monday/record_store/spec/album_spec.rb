require 'rspec'
require 'pry'

require 'album'

describe '#Album' do
  before(:each) do
    Album.clear
  end

  describe '.all' do
    it 'is empty at the beginning' do
      expect(Album.all).to eq([])
    end
  end

  describe '.find' do
    it 'finds album by its id' do
      album = Album.new('Bear')
      album2 = Album.new('Tyger')
      album.save
      album2.save
      expect(Album.find(album.id)).to eq(album)
    end
  end

  describe '.search' do
    it 'finds album by its name and not find non-existent one' do
      album = Album.new('Dream')
      album2 = Album.new('Life')
      album.save
      album2.save

      expect(Album.search('Dream')).to eq(album)
      expect(Album.search('False')).to eq(nil)
    end
  end

  describe '.sort' do
    it 'returns the list of all albums, sorted by name' do
      names = (1..5).to_a.map(&:to_s)
      names.shuffle.each { |name| Album.new(name).save }

      expect(Album.sort.map(&:name)).to eq(names)
    end
  end

  describe '#==' do
    it 'albums with same names are equal' do
      expect(Album.new("Blue") == Album.new("Blue")).to eq(true)
    end
  end

  describe '#save' do
    it 'saves albums' do
      album = Album.new("Black")
      album2 = Album.new("Blue")
      album.save
      album2.save
      expect(Album.all).to eq([album, album2])
    end
  end

  describe '.clear' do
    it 'clears all albums' do
      album = Album.new('Brown')
      album2 = Album.new('Red')
      album.save
      album2.save
      Album.clear
      expect(Album.all).to eq([])
    end
  end

  describe '#update' do
    it 'updates album info by id' do
      # does not update database, but this spec is from the textbook
      album = Album.new('Duck')
      album.update('Frog')
      expect(album.name).to eq('Frog')
    end
  end

  describe '#delete' do
    it 'deletes the album by id' do
      album = Album.new('Bat')
      album.save
      album2 = Album.new('Crow')
      album2.save
      album.delete
      expect(Album.all).to eq([album2])
    end
  end

  describe '#sold' do
    it 'removes album from the list' do
      (1..5).to_a.map(&:to_s).each do |name|
        Album.new(name).save
      end
      album = Album.search '3'
      album.sold
      expect(Album.all.none?(album)).to be(true)
    end

    it 'sold albums appears in list of sold ones' do
      (1..5).to_a.map(&:to_s).each do |name|
        Album.new(name).save
      end
      album = Album.search '3'
      album.sold
      expect(Album.all_sold.any?(album)).to be(true)
    end
  end

  describe('#songs') do
    it("returns an album's songs") do
      album = Album.new("Giant Steps", nil)
      album.save()
      song = Song.new("Naima", album.id, nil)
      song.save()
      song2 = Song.new("Cousin Mary", album.id, nil)
      song2.save()
      expect(album.songs).to(eq([song, song2]))
    end
  end
end

