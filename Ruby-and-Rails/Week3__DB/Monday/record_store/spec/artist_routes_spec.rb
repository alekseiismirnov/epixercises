# frozen_string_literal: true

require_relative './spec_helper.rb'
require_relative './populate_db.rb'

Capybara.app = Sinatra::Application

Capybara.save_path = '~/tmp'

describe('GET routes for Artis', type: :feature) do
  before :each do
    AllArtistsAllAlbums.new(artists_number: 5, albums_number: 10)
  end

  context 'Basic CRUD functionality' do
    it 'allow to retrieve a list of all' do
      visit '/artists'

      expect(page.status_code).to eq 200
      expect(find('h1').text).to eq 'Artists'
      within('.artists') do
        expect(all('.artist').map(&:text)).to match_array Artist.all.map(&:name)
      end
    end

    it 'allow to retrieve a single instance' do
      visit '/artists/20'

      expect(page.status_code).to eq 200
    end
  end
end
