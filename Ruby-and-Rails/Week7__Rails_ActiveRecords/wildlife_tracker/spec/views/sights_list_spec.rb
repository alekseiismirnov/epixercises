require 'rails_helper'

class BackForest
  attr_reader :sights_data
end

describe('Sights report', type: :feature) do
  before :each do
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

  it 'shows all sights during a given time period'
  it 'shows all sights in a particular region'
end
