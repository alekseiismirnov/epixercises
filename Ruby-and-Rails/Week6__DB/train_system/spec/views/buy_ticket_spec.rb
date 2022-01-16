# frozen_string_literal: true

require_relative '../spec_helper'

class ColorLines
  attr_reader :cities
end

describe('View train page with number and timetabe', type: :feature) do
  before :all do
    railway = ColorLines.new
    cities = railway.cities
    city_id = cities['Ljviv'].id

    @trains = cities['Ljviv'].stops.map(&:train)
    visit "/cities/#{city_id}"
  end

  it 'allows buy ticket to selected train from city page' do
    within(find('.train', text: 'Blue')) do
      click_button 'Buy ticket'
    end

    expect(page.status_code).to eq 200

    within('.train') do
      expect(page).to have_content 'Blue'
    end

    within('.departure') do
      expect(page).to have_content 'Ljviv'
    end
  end
end
