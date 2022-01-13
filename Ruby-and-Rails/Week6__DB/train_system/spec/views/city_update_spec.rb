# frozen_string_literal: true

require_relative '../spec_helper'

class ColorLines
  attr_reader :cities
end

describe('Edit city', type: :feature) do
  before :all do
    railway = ColorLines.new
    @cities = railway.cities
    @city_id = @cities['Kyjiv-Pas.'].id
    visit "/cities/#{@city_id}/edit"
  end

  it 'Change trains number in database' do
    expect(page.status_code).to eq 200

    fill_in 'name',	with: 'Kyjiv'
    click_button 'Update'

    expect(page.status_code).to eq 200

    expect(City.find(@city_id).name).to eq 'Kyjiv'
  end
end
