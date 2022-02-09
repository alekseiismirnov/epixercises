require 'rails_helper'

describe('Show animal', type: :feature) do
  it 'shows animal species' do
    animal = Animal.create(species: 'Vydra')
    visit "/animals/#{animal.id}"

    expect(page.status_code).to eq 200
    expect(find('h1').text).to eq 'Vydra'
  end
end
