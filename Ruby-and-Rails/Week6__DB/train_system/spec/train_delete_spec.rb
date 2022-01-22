# frozen_string_literal: true

require_relative 'spec_helper'

class ColorLines
  attr_reader :trains
end

describe('Delete train', type: :feature) do
  before :all do
    railway = ColorLines.new
    @trains = railway.trains
  end

  it 'deletes train from the db and all related stops' do
    train = @trains['Blue']
    train_id = train.id
    stop_ids = train.stops.map(&:id)
    train.delete

    expect(Train.all.map(&:id)).not_to include train_id
    expect(Stop.all.map(&:id)).not_to include(*stop_ids)
  end
end
