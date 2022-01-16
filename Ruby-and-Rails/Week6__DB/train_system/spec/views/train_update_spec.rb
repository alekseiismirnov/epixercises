# frozen_string_literal: true

require_relative '../spec_helper'

class ColorLines
  attr_reader :trains, :red_stops, :cities
end

describe('Edit train', type: :feature) do
  before :all do
    railway = ColorLines.new
    @trains = railway.trains
    @train_id = @trains['Red'].id
    @stops = railway.red_stops

    @new_stop = Stop.new(minutes: 30)
    @new_stop.save
    @new_stop.add_related(railway.cities['Donecjk'])

    visit "/trains/#{@train_id}/edit"
  end

  it 'Change trains number in database' do
    expect(page.status_code).to eq 200

    fill_in 'stops',	with: @new_stop.id
    click_button 'Update'

    expect(page.status_code).to eq 200

    expect(@trains['Red'].stops).to match_array @stops.values + [@new_stop]
  end
end
