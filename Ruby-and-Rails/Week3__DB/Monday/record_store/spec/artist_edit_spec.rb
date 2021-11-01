# frozen_string_literal: true

require_relative './spec_helper.rb'
require_relative './populate_db.rb'

Capybara.app = Sinatra::Application

Capybara.save_path = '~/tmp'

describe('Edit Artist', type: :feature) do
  before :each do
    @name = 'Chuck Blueberry'
    @new_name = 'Chuck Blackberry'
    Artist.new(name: @name).save
  end
  context 'from artist list page' do
    it 'is possible to edit artist name' do
      visit '/artists'
      click_on @name

      expect(page.status_code).to eq 200

      fill_in 'artists_name',	with: @new_name
      click_button 'Update!'

      expect(page.status_code).to eq 200
      within('.artists') do
        expect(page).to have_content @new_name
      end
    end
  end
end
