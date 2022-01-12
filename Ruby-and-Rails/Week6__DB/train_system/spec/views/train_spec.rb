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

    visit "/trains/#{@train.id}"
  end

  it 'exists and has a train number and a timetable' do
    expect(page.status_code).to eq 200
    expect(find('h1').text).to eq 'Train Blue'
  end
end
