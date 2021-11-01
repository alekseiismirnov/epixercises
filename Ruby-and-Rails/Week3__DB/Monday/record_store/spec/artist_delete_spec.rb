# frozen_string_literal: true

require_relative './spec_helper.rb'
require_relative './populate_db.rb'

Capybara.app = Sinatra::Application

Capybara.save_path = '~/tmp'

describe('Delete Artist', type: :feature) do
  before :each do
    @name = 'Chuck Blueberry'
    @artist = Artist.new(name: @name)
    @artist.save
    @other_name = 'Jack Migger'
    Artist.new(name: @other_name).save
  end

  context 'from artist list page' do
    it 'is possible to delete artist name' do
      visit '/artists'
      click_on @name

      expect(page.status_code).to eq 200

      click_button 'Delete!'

      expect(page.status_code).to eq 200
      within('.artists') do
        expect(page).to have_no_content @name
        expect(page).to have_content @other_name
      end
    end
  end
end
