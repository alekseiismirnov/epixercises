# frozen_string_literal: true

require 'date'
require_relative '../spec_helper.rb'

require 'doctor'
require 'patient'

describe 'Relative' do
  context 'after adding to the object related ones' do
    before :each do
      @doctor = Doctor.new(name: 'Well Known', speciality: 'specialist #1')
      @doctor.save

      @patients = ('Name A'..'Name E').to_a.zip(('1 May 1991'..'1 May 1995').to_a).map do |name, date|
        Patient.new(name: name, birthdate: date)
      end
      @patients.each(&:save)

      @patients[1, 3].each { |patient| @doctor.add_related patient }
    end

    it '#<related> allows to get all of them' do
      expect(@doctor.patients).to match_array @patients[1, 3]
    end
  end
end
