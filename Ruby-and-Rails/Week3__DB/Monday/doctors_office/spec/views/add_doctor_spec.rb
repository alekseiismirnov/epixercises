# frozen_string_literal: true

require_relative '../spec_helper.rb'

describe('Adding a new doctor', type: :feature) do
  context 'from the `add new` page' do
    before :each do
      visit '/doctors/new'
    end

    it 'there is an appropriate form for new doctor record creation' do
      expect(page.status_code).to eq 200
      within '.form_new' do
        fill_in 'name',	with: 'Some Name'
        fill_in 'speciality', with: 'specialist #10'
        click_button 'Add'
      end
save_and_open_page
      expect(page.status_code).to eq 200 # at least route is correct

      expect(Doctor.all.first).to eq Doctor.new(
        name: 'Some Name',
        speciality: 'specialist #10'
      )
    end
  end
end
