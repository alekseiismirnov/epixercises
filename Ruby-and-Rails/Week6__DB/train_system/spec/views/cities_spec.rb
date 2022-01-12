# frozen_string_literal: true

require_relative '../spec_helper'

class ColorLines
  attr_reader :cities
end

describe('View cities', type: :feature) do
  before :all do
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
end
