# frozen_string_literal: true

require_relative '../spec_helper'

class ColorLines
  attr_reader :trains
end

describe('View trains', type: :feature) do
  before :each do
    railway = ColorLines.new
    @trains = railway.trains
    @train = @trains['Blue']
    visit '/trains'
  end

  it 'exists, has a list of links to trains' do
    expect(page.status_code).to eq 200
    expect(find('h1').text).to eq 'Trains'
    within('.trains_list') do
      expect(all('a').map(&:text)).to match_array @trains.keys
    end

    click_on 'Blue'
    expect(page.status_code).to eq 200
    expect(find('h1').text).to eq 'Train Blue'
  end

  it 'allows to add new train' do
    click_on 'Add'
    expect(page.status_code).to eq 200

    fill_in 'number', with: 'Silver'
    click_button 'Add'

    expect(Train.all.map(&:number)).to include 'Silver'
  end
end
