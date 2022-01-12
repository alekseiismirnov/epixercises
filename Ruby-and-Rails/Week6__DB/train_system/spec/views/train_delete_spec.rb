# frozen_string_literal: true

require_relative '../spec_helper'

class ColorLines
  attr_reader :trains
end

describe('Delete train', type: :feature) do
  before :all do
    railway = ColorLines.new
    @trains = railway.trains
    visit '/trains'
  end

  it 'delete train from the db' do
    expect(page.status_code).to eq 200

    within(find('.train', text: 'Blue')) do
      click_button 'Delete'
      expect(page.status_code).to eq 200
    end

    @trains.delete('Blue')
    expect(Train.all).to match_array @trains.values
  end
end
