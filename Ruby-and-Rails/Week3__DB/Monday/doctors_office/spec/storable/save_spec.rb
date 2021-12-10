# frozen_string_literal: true

require_relative '../spec_helper.rb'

describe '.find' do
  context 'if nothing saved' do
    it 'returns nil' do
      expect(Mocktor.find(1)).to eq nil
    end
  end
end

describe '#save' do
  before :all do
    @doctor = Mocktor.new(
      name: 'Mocktor',
      speciality: 'specialist'
    )
    @id = @doctor.save
  end

  it 'saves himself' do
    doctor = Mocktor.find @id

    expect(doctor.name).to eq 'Mocktor'
    expect(doctor.speciality).to eq 'specialist'

    expect(doctor).to eq @doctor
  end
end
