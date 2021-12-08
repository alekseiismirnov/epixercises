# frozen_string_literal: true

require_relative '../spec_helper.rb'

describe('List assigned patients', type: :feature) do
  context 'there is a doctor and some patients are assigned to' do
    before :each do
      @doctor = Doctor.new(name: 'Free One', speciality: 'whatever')
      @doctor.save

      @assigned_patients = ('Patient A'..'F').map { |name| Patient.new(name: name, birthdate: '3 Mar 1802') }
      @assigned_patients.each(&:save)
      @assigned_patients.each do |patient|
        @doctor.add_related patient
      end

      @unassigned_patients = ('Patient L'..'Patient Y').map { |name| Patient.new(name: name, birthdate: '3 Mar 1802') }
      @unassigned_patients.each(&:save)

      @assigned_patients.each { |patient| @doctor.add_related(patient) }
    end

    it 'only assigned patients are listed' do
      visit "/doctors/#{@doctor.id}/patients"

      expect(page.status_code).to eq 200

      within '.patients_list' do
        expect(all('.patient').map(&:text)).to match_array @assigned_patients.map(&:name)
      end
    end
  end
end
