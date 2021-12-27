# frozen_string_literal: true

require_relative '../spec_helper.rb'

describe('Assing volonteer', type: :feature) do
  before :all do
    SnakePot.new

    @animal = Animal.all.first
    @volonteer = Volonteer.all.last
  end

  it 'adds the volonteer to the animal' do
    visit "/animals/#{@animal.id}/assign_volonteer"
    expect(page.status_code).to eq 200

    within('.form_add') do
      expect(page).to have_content 'Volonteer ID'

      fill_in 'volonteer_id',	with: @volonteer.id
      click_button 'Add'
      expect(page.status_code).to eq 200

      expect(@animal.volonteer).to eq @volonteer
    end
  end
end
