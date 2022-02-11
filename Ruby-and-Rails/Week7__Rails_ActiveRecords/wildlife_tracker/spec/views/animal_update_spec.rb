class BackForest
  attr_reader :animals_specs
end

describe('Update animal', type: :feature) do
  before :all do
    Animal.delete_all

    forest = BackForest.new
    @animals_species = forest.animals_specs
    @animal = Animal.all.first
    @animal_species = @animal.species
  end

  it 'changes animal species' do
    visit "/animals/#{@animal.id}/edit"
    expect(page).to have_http_status(:success)

    fill_in('animal_species', with: 'Purple Frog')
    click_button 'Update Animal'
    expect(page).to have_http_status(:success)

    expect(Animal.all.map(&:species)).to include 'Purple Frog'
    expect(Animal.all.map(&:species)).to_not include @animal_species
  end
end
