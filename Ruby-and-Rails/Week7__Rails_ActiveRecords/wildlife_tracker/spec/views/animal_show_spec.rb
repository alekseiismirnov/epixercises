require 'rails_helper'

describe('Show animal', type: :feature) do
  it 'shows animal species' do
    Animal.destroy_all
    animal = Animal.create(species: 'Vydra')
    locations = (1..10).map(&:to_f).zip((101..110).map(&:to_f))
    locations.each { |location| animal.sights.create(location: location) }

    visit "/animals/#{animal.id}"

    expect(page.status_code).to eq 200
    expect(find('h1').text).to eq 'Vydra'

    expect(all('#location').map(&:text)).to match_array(locations.map { |x, y| "#{x}, #{y}" })
 
    expect(page).to have_link('Edit', href: "/animals/#{animal.id}/edit")
    expect(page).to have_link('Delete', href: "/animals/#{animal.id}")
  end
end
