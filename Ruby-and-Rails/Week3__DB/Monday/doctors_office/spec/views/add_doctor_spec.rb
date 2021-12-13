# frozen_string_literal: true

require_relative '../spec_helper.rb'

describe('Adding a new doctor', type: :feature) do
  before :all do
    @specialities = (0..12).map do |i|
      Speciality.new(speciality: "specialist ##{i}")
    end

    @specialities.each(&:save)
  end

  context 'from the `add new` page' do
    it 'there is an appropriate form for new doctor record creation' do
      visit '/specialities'
      expect(page.status_code).to eq 200

      within '.specialities_list' do
        click_on 'specialist #10'
        expect(page.status_code).to eq 200
      end

      within '.form_new' do
        fill_in 'name',	with: 'Some Name'
        click_button 'Add'
      end

      expect(page.status_code).to eq 200 # at least route is correct

      doctor = Doctor.all.first
      expect(doctor.name).to eq 'Some Name'
      expect(doctor.speciality).to eq 'specialist #10'
    end
  end
end
