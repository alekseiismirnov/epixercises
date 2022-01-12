# frozen_string_literal: true

require_relative '../spec_helper'

class ColorLines
  attr_reader :cities
end

describe('Add new city', type: :feature) do
  before :all do
    railway = ColorLines.new
    @cities = railway.cities
    visit '/cities/new'
  end

  it 'adds new city to database' do
    expect(page.status_code).to eq 200

    fill_in 'name',	with: 'Donetcjk'
    click_button 'Add'

    expect(page.status_code).to eq 200

    expect(City.all.map(&:name)).to include 'Donetcjk'
  end
end
