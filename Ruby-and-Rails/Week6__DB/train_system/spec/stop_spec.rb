# mostly for the smoke test of mock data generator
require 'spec_helper'

class ColorLines
  attr_reader :red_stops
end

describe Stop do
  before :each do
    @stop = ColorLines.new.red_stops['Dnipro-Gholovnyj']
  end

  it 'shows the stop time' do
    expect(@stop.minutes).to eq 3
  end

  it 'knows his city and train' do
    expect(@stop.city.name).to eq 'Dnipro-Gholovnyj'
    expect(@stop.train.number).to eq 'Red'
  end
end
