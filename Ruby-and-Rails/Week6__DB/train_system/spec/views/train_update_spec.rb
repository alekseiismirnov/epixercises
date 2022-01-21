# frozen_string_literal: true

require_relative '../spec_helper'

class ColorLines
  attr_reader :trains, :red_stops, :cities
end

describe('Edit train', type: :feature) do
  before :each do
    railway = ColorLines.new
    @trains = railway.trains
    @train_id = @trains['Red'].id
    @stops = railway.red_stops
    @city = railway.cities['Lugansjk']

    visit "/trains/#{@train_id}/edit"
  end

  it 'changes a train number' do
    expect(page.status_code).to eq 200

    fill_in 'number',	with: 'Bright Red'
    click_button 'Update'

    expect(page.status_code).to eq 200

    expect(Train.find(@train_id).number).to eq 'Bright Red'
  end

  it 'allows create and add new a stop' do
    within('.add_stop') do
      select 'Lugansjk', from: 'cities'
      fill_in 'minutes', with: '45'
    end
    click_button 'Update'

    expect(page.status_code).to eq 200

    stop = Train.find(@train_id).stops.last

    expect(stop.city).to eq @city
    expect(stop.minutes).to eq 45
  end
end
