# frozen_string_literal: true

require_relative '../spec_helper'

class ColorLines
  attr_reader :cities
end

describe('View cities', type: :feature) do
  before :each do
    railway = ColorLines.new
    @cities = railway.cities
    visit '/cities'
  end

  it 'exists, has a list of links to trains' do
    expect(page.status_code).to eq 200
    expect(find('h1').text).to eq 'Cities'
    within('.cities_list') do
      expect(all('a').map(&:text)).to match_array @cities.keys
    end

    click_on 'Bila Cerkva'
    expect(page.status_code).to eq 200
    expect(find('h1').text).to eq 'Bila Cerkva'
  end

  it 'allows to add new city' do
    click_on 'Add'
    expect(page.status_code).to eq 200

    fill_in 'name', with: 'Kolomyja'
    click_button 'Add'

    expect(City.all.map(&:name)).to include 'Kolomyja'
  end
end
