# mostly for the smoke test of mock data generator

class ColorLines
  attr_reader :red_stops
end

describe Stop do
  before :all do
    @stop = ColorLines.new.red_stops['Dnipro-Gholovnyj']
  end

  it 'shows the stop time' do
    expect(@stop.minutes).to eq 3
  end
end
