# frozen_string_literal: true

require_relative '../spec_helper.rb'

describe('Assign a patient to the doctor', type: :feature) do
  context 'from the `edit` page' do
    before :each do
      @doctor = Doctor.new(name: 'Free One', speciality: 'whatever')
      @patient = Patient.new(name: 'Choosen 1', birthdate: '19 Apr 1878')
      @doctor.save
      @patient.save

      visit "/patient/#{@patient.id}/assign_doctor"
    end

    it 'there is a field for doctors id and a button' do
      expect(page.status_code).to eq 200

      within '.form_add' do
        expect(page).to have_content 'Doctor ID:'

        fill_in 'doctor_id', with: @doctor.id

        click_button 'Add'
      end

      expect(page.status_code).to eq 200 # at least route is correct

      expect(@doctor.patients.first).to eq Patient.new(
        name: 'Choosen 1',
        birthdate: '19 Apr 1878'
      )
    end
  end
end
