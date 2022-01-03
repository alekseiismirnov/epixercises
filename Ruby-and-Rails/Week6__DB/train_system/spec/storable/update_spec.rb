# frozen_string_literal: true

require 'date'
require_relative '../spec_helper.rb'

describe '#update' do
  context 'for saved classes' do
    before :each do
      @records = [['Bob', 'Jan 2 1980'],
                  ['Lars', 'Nov 3 1999'],
                  ['Debra', 'Sep 29 1984']]
      @patients = @records.map { |n, d| Faketient.new(name: n, birthdate: d) }
      @patients.each(&:save)
    end

    it 'can change value of one field' do
      @patients[1].update(name: 'Shmars')
      expect(Faketient.find(@patients[1].id).name).to eq 'Shmars'
      expect(Faketient.find(@patients[1].id).birthdate).to eq Date.parse('Nov 3 1999')
    end

    it 'can change value of two field also' do
      @patients[2].update(name: 'Zebra', birthdate: 'June 12 2004')

      expect(Faketient.find(@patients[2].id)).to eq Faketient.new(name: 'Zebra', birthdate: 'June 12 2004')
    end
  end
end
