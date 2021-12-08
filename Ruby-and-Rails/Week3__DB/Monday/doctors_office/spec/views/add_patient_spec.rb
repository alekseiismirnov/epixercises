# frozen_string_literal: true

require_relative '../spec_helper.rb'

describe('Adding a new patient', type: :feature) do
  context 'from the `add new` page' do
    before :each do
      visit '/patients/new'
    end

    it 'there is an appropriate form for new patient record creation' do
      expect(page.status_code).to eq 200
      within '.form_new' do
        fill_in 'name',	with: 'Any Body'
        fill_in 'birthdate', with: '22 Jan 1921'
        click_button 'Add'
      end

      expect(page.status_code).to eq 200 # at least route is correct

      expect(Patient.all.first).to eq Patient.new(
        name: 'Any Body',
        birthdate: '22 Jan 1921'
      )
    end
  end
end
