require 'rails_helper'

describe('Show animal', type: :feature) do
  it 'shows animal species' do
    Animal.destroy_all
    animal = Animal.create(species: 'Vydra')
    visit "/animals/#{animal.id}"

    expect(page.status_code).to eq 200
    expect(find('h1').text).to eq 'Vydra'

    expect(page).to have_link('Edit', href: "/animals/#{animal.id}/edit")
    expect(page).to have_link('Delete', href: "/animals/#{animal.id}")
  end
end
