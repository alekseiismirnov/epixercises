describe('Adding new sight for animal', type: :feature) do
  before :all do
    Animal.delete_all
    @animal = Animal.create(species: 'Bandrersnatch')
    @location = [48.954410, 24.689311]
  end

  it 'adds new animals sight' do
    visit "/animals/#{@animal.id}"

    click_on 'Add sight'
    expect(page).to have_http_status(:success)

    fill_in 'Location',	with: '48.954410, 24.689311'

    click_button 'Create Sight'
    expect(page).to have_http_status(:success)

    expect(@animal.sights.first).to eq @location
  end
end
