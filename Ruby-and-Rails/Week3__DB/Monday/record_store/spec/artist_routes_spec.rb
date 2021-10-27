# frozen_string_literal: true

require_relative './spec_helper.rb'
require_relative './spec_integration_helper.rb'

describe('GET routes for Artis', type: :feature) do
  context 'Basic CRUD functionality' do
    it 'allow to retrieve a list of all' do
      visit '/artists'

      expect(page.status_code).to eq 200
    end

    it 'allow to retrieve a single instance' do
      visit '/artists/20'

      expect(page.status_code).to eq 200
    end
  end
end
