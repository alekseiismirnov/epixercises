# frozen_string_literal: true

require_relative 'spec_helper'

class ColorLines
  attr_reader :cities
end

describe('Delete city', type: :feature) do
  before :all do
    railway = ColorLines.new
    @cities = railway.cities
  end

  it 'delete city from the db' do
    city = @cities['Ljviv']
    city_id = city.id
    stop_ids = city.stops.map(&:id)

    city.delete

    expect(City.all.map(&:id)).to_not include city_id
    expect(Stop.all.map(&:id)).to_not include(*stop_ids)
  end
end
