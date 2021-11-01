# frozen_string_literal: true

require_relative './spec_helper.rb'
require_relative './populate_db.rb'

Capybara.app = Sinatra::Application

Capybara.save_path = '~/tmp'

describe('Add Artist', type: :feature) do
  context 'from artist list page' do
    it 'is possible to create new artist' do
      visit '/artists'
      click_on 'New Artist'

      expect(page.status_code).to eq 200

      fill_in 'artists_name',	with: 'Chuck Breadberry'
      click_button 'Go'

      expect(page.status_code).to eq 200
      within('.artists') do
        expect(page).to have_content 'Chuck Breadberry'
      end
    end
  end
end
