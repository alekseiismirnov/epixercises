# frozen_string_literal: true

require 'date'
require_relative '../spec_helper.rb'

describe('Report page with default report', type: :feature) do
  context 'there are 5 doctors with 20 patients assigned' do
    before :each do
      @doctors = ('Name A'..'Name E').map do |name|
        Doctor.new(name: name, speciality: 'anything')
      end

      @doctors.shuffle.each(&:save) # we also test sorting

      patients = ('1'..'100').to_a.zip(('1 May 1891'..'1 May 1991').to_a)
                             .map do |name, date|
        Patient.new(name: name, birthdate: date)
      end

      patients.each(&:save)

      patients.each do |patient|
        @doctors[patient.name.to_i % 5].add_related patient
      end
    end

    it 'render page with sorted list of doctors with the number of patiens' do
      visit '/reports/doctors/patiens'
      expect(page.status_code).to eq 200

      within_table('Report') do
        expect(all('.doctor').map(&:text)).to eq @doctors.map(&:name)
        expect(all('.patients_number').map(&:text)).to eq ['20'] * 5
      end
    end
  end
end
