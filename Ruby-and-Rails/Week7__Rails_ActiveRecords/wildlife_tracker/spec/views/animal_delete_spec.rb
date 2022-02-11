require 'rails_helper'

describe('Delete animal', type: :feature) do
  it 'allows to delete an animal' do
    animal = Animal.create(species: 'Apple Worm')
    visit "/animals/#{animal.id}"

    click_on 'Delete'
    expect(page).to have_http_status(:success)
  end
end
