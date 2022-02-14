class BackForest
  attr_reader :animals_specs
end

describe('Animals list', type: :feature) do
  before :all do
    Animal.destroy_all
    forest = BackForest.new
    @specs = forest.animals_specs
  end

  it('Shows all animals in the system') do
    visit '/animals'
    expect(page.status_code).to eq 200

    expect(all('#spec').map(&:text)).to match_array @specs

    expect(page).to have_link('Add new animal', href: '/animals/new')
  end
end
