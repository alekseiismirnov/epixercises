require 'rails_helper'

class BackForest
  attr_reader :sights_data
end

describe('Sights report', type: :feature) do
  before :all do  # no data should be harmed here
    forest = BackForest.new
    @sights = forest.sights_data
  end

  it 'shows all sights' do
    visit '/sights'
    expect(page).to have_http_status(:success)

    expect(all('#species').map(&:text)).to match_array(@sights.map { |record| record[:species] })
    expect(all('#region_name').map(&:text)).to match_array(@sights.map { |record| record[:region_name] })
    expect(all('#location').map(&:text)).to match_array(@sights.map { |record| '%f, %f' % record[:location] })
    expect(all('#date').map(&:text)).to match_array(@sights.map { |record| record[:date] })
  end

  it 'shows all sights during a given time period' do
    visit '/sights'

    fill_in 'min_date', with: '17-02-2017'
    fill_in 'max_date', with: '03-09-2019'

    click_button 'Filter'
    expect(page).to have_http_status(:success)

    expected_locations = ['30.823760, 40.234930', '32.823760, 42.287830', '31.768341, 42.988340',
                          '35.983540, 40.892230']
    expect(all('#location').map(&:text)).to match_array(expected_locations)
  end

  it 'shows all sights in a particular region'
end
