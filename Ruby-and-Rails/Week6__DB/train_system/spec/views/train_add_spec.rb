# frozen_string_literal: true

require_relative '../spec_helper'

class ColorLines
  attr_reader :trains
end

describe('Add new train', type: :feature) do
  before :all do
    railway = ColorLines.new
    @trains = railway.trains
    visit '/trains/new'
  end

  it 'adds new train to database' do
    expect(page.status_code).to eq 200

    fill_in 'number',	with: 'Red 1'
    click_button 'Add'

    expect(page.status_code).to eq 200

    expect(Train.all.map(&:number)).to include 'Red 1'
  end
end
