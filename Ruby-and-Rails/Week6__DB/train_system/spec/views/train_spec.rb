# frozen_string_literal: true

require_relative '../spec_helper'

class ColorLines
  attr_reader :trains, :blue_stops
end

describe('View train page with number and timetabe', type: :feature) do
  before :all do
    railway = ColorLines.new
    @train = railway.trains['Blue']
    @stops = railway.blue_stops
    @cities = @stops.values.map(&:city)
    @minutes = @stops.values.map(&:minutes)

    visit "/trains/#{@train.id}"
  end

  it 'exists and has a train number and a timetable' do
    expect(page.status_code).to eq 200
    expect(find('h1').text).to eq 'Train Blue'
    expect(first('h2').text).to eq 'Timetable'
    within('.timetable') do
      expect(all('.city').map(&:text)).to eq @cities.map(&:name)
      expect(all('.time').map(&:text)).to eq @minutes.map(&:to_s)
    end
  end
end
