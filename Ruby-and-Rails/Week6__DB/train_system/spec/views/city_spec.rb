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

    @trains = cities['Ternopilj'].stops.map(&:train)
    visit "/cities/#{city_id}"
  end

  it 'exists and has a train number and a timetable' do
    expect(page.status_code).to eq 200
    expect(find('h1').text).to eq 'Ternopilj'
    within('.trains') do
      expect(all('.train_number').map(&:text)).to eq @trains.map(&:number)
    end
  end
end
