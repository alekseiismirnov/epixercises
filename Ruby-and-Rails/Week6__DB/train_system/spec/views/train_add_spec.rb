# frozen_string_literal: true

require_relative '../spec_helper'

class ColorLines
  attr_reader :trains, :cities
end

describe('Add new train', type: :feature) do
  before :all do
    railway = ColorLines.new
    @trains = railway.trains
    @cities = railway.cities.values[0, 5]
    @stops = (1..5).map { |minutes| Stop.new(minutes: minutes) }
    @stops.zip(@cities) do |stop, city|
      stop.save
      stop.add_related city
    end

    visit '/trains/new'
  end

  it 'adds new train to database' do
    expect(page.status_code).to eq 200

    fill_in 'number',	with: 'Red 1'
    fill_in 'stops', with: @stops.map(&:id).join(', ')
    click_button 'Add'

    expect(page.status_code).to eq 200

    expect(Train.all.map(&:number)).to include 'Red 1'

    new_train = Train.all.select { |train| train.number == 'Red 1' }.first
    expect(new_train.stops).to match_array @stops
  end
end
