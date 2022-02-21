require 'rails_helper'

describe('Adding new sight for animal', type: :feature) do
  before :all do
    Animal.destroy_all
    Sight.destroy_all
    Region.destroy_all

    @animal = Animal.create(species: 'Bandrersnatch')
    @region = Region.create(name: 'Warmwood')
    %w[Yellow Red Green].each { |name| Region.create(name: name)}
  end

  it 'adds new animals sight' do
    visit "/animals/#{@animal.id}"

    click_on 'Add sight'
    expect(page).to have_http_status(:success)

    fill_in 'Location',	with: '48.954410, 24.689311'
    select 'Warmwood', from: 'Select Region'

    select '2017', from: 'sight_date_1i'
    select 'June', from: 'sight_date_2i'
    select '30', from: 'sight_date_3i'

    click_button 'Create Sight'
    expect(page).to have_http_status(:success)

    sight = @animal.sights.first
    expect(sight.latitude).to eq 48.954410
    expect(sight.longtitude).to eq 24.689311
    expect(sight.region).to eq @region
  end
end
