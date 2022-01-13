# frozen_string_literal: true

require_relative '../spec_helper'

class ColorLines
  attr_reader :trains
end

describe('Edit train', type: :feature) do
  before :all do
    railway = ColorLines.new
    @trains = railway.trains
    @train_id = @trains['Yellow'].id
    visit "/trains/#{@train_id}/edit"
  end

  it 'Change trains number in database' do
    expect(page.status_code).to eq 200

    fill_in 'number',	with: 'Orange Bright'
    click_button 'Update'

    expect(page.status_code).to eq 200

    expect(Train.find(@train_id).number).to eq 'Orange Bright'
  end
end
