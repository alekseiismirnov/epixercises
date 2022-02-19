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

  it 'lists all regions' do
    visit '/regions'
    expect(page).to have_http_status(:success)
    expect(all('#region').map(&:text)).to match_array @regions_names
  end
end
