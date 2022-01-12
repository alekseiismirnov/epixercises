# frozen_string_literal: true

require_relative '../spec_helper'

class ColorLines
  attr_reader :cities
end

describe('Delete city', type: :feature) do
  before :all do
    railway = ColorLines.new
    @cities = railway.cities
    visit '/cities'
  end

  it 'delete city from the db' do
    expect(page.status_code).to eq 200

    within(find('.city', text: 'Kharkiv-Pas.')) do
      click_button 'Delete'
      expect(page.status_code).to eq 200
    end

    @cities.delete('Kharkiv-Pas.')
    expect(City.all).to match_array @cities.values
  end
end
