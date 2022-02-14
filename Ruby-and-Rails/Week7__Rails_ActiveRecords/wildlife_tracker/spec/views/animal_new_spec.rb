class BackForest
  attr_reader :animals_specs
end

describe('Create new animal page', type: :feature) do
  before :all do
    Animal.destroy_all

    forest = BackForest.new
    @species = forest.animals_specs
  end

  it 'allows to create new animal' do
    visit '/animals/new'
    expect(page.status_code).to eq 200

    fill_in('animal_species', with: 'Purple Frog')
    click_button 'Create Animal'
    expect(page.status_code).to eq 200

    expect(Animal.all.map(&:species)).to match_array @species + ['Purple Frog']
  end
end
