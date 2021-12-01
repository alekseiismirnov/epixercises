# frozen_string_literal: true

require_relative '../spec_helper.rb'

describe '.search' do
  context 'empty base' do
    it 'finds nothing' do
      findings = Doctor.columns.map do |column|
        Doctor.search(column => 'Whatever you want')
      end

      expect(findings).to eq [[], []]
    end
  end

  context 'populated base' do
    before :each do
      @name_1time = 'Rare Name'
      @name_2times = 'Not Rare'
      @name_5times = 'Rather Common'

      @names = [@name_1time, *[@name_2times] * 2, *[@name_5times] * 5]
      @specialities = ('speciality #1'..'speciality #8').to_a

      @doctors = @names.zip(@specialities).map do |n, s|
        Doctor.new(name: n, speciality: s)
      end

      @doctors.each(&:save)
    end

    it 'finds by unique parameter one item' do
      doctors = Doctor.search(speciality: 'speciality #4')
      expect(doctors.length).to eq 1
      expect(doctors.first).to eq @doctors[3]
    end

    it 'can find two' do
      doctors = Doctor.search(name: 'Not Rare')
      expect(doctors).to match_array @doctors[1, 2]
    end

    it 'can find even more' do
      doctors = Doctor.search(name: 'Rather Common')
      expect(doctors).to match_array @doctors[3, 5]
    end
  end
end
