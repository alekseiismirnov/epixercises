# frozen_string_literal: true

require_relative '../spec_helper'

class ColorLines
  attr_reader :cities
end

describe('View train page with number and timetabe', type: :feature) do
  before :all do
    railway = ColorLines.new
    cities = railway.cities
    city_id = cities['Ternopilj'].id
    visit "/cities/#{city_id}"
  end

  it 'exists and has a train number and a timetable' do
    expect(page.status_code).to eq 200
    expect(find('h1').text).to eq 'Ternopilj'
  end
end
