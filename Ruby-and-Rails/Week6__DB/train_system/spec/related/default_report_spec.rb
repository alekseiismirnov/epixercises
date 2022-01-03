# frozen_string_literal: true

require 'date'
require_relative '../spec_helper.rb'

describe 'Relative' do
  context '#default_report' do
    before :each do
      @doctors = ('Name A'..'Name E').map do |name|
        Mocktor.new(name: name, speciality: 'anything')
      end

      @doctors.shuffle.each(&:save) # we also test sorting

      patients = ('1'..'100').to_a.zip(('1 May 1891'..'1 May 1991').to_a)
                             .map do |name, date|
        Faketient.new(name: name, birthdate: date)
      end

      patients.each(&:save)

      patients.each do |patient|
        @doctors[patient.name.to_i % 5].add_related patient
      end
    end

    it 'returns sorted doctors with the number of their patienst' do
      expect(Mocktor.default_report(:faketients)).to eq @doctors.zip([20] * 5)
    end
  end
end
