require 'rails_helper'

describe('Show animal', type: :feature) do
  before :each do
    Animal.destroy_all
    @animal = Animal.create(species: 'Vydra')
    @locations = (1..10).map(&:to_f).zip((101..110).map(&:to_f))
    @locations.each { |location| @animal.sights.create(location: location) }
  end

  it 'shows animal species and sights' do
    visit "/animals/#{@animal.id}"
    expect(page).to have_http_status(:success)

    expect(find('h1').text).to eq 'Vydra'

    expect(all('#location').map(&:text)).to match_array(@locations.map { |x, y| "#{x}, #{y}" })

    expect(page).to have_link('Edit', href: "/animals/#{@animal.id}/edit")
    expect(page).to have_link('Delete', href: "/animals/#{@animal.id}")
  end

  it 'allows to delete a sight' do
    visit "/animals/#{@animal.id}"
    expect(page).to have_http_status(:success)

    within(find('#sight', text: '5.0, 105.0')) do
      click_on 'Delete'
    end
    expect(page).to have_http_status(:success)

    @locations.delete([5, 105])
    expect(all('#location').map(&:text)).to match_array(@locations.map { |x, y| "#{x}, #{y}" })
  end
end
