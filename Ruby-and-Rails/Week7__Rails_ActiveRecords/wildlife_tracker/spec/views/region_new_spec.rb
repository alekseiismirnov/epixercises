require 'rails_helper'

class BackForest
  attr_reader :regions_names
end

describe('Region list', type: :feature) do
  before :each do
    Animal.destroy_all
    Region.destroy_all
    forest = BackForest.new
    @regions_names = forest.regions_names
  end

  it 'allows create new region' do
    visit '/regions/new'
    expect(page).to have_http_status(:success)

    fill_in('region_name', with: 'Yellow Waters')
    click_button 'Create Region'
    expect(page).to have_http_status(:success)

    expect(Region.all.map(&:name)).to match_array(@regions_names + ['Yellow Waters'])
  end
end
