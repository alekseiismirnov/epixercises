# frozen_string_literal: true

require_relative '../spec_helper.rb'

class Doctor
  include Storable

  assign_table :doctors
  assign_columns %i[name speciality]

  attr_reader :id, :name, :speciality

  def initialize(params)
    params = Hash[params.map { |k, v| [k.to_sym, v] }]

    @id = params[:id] if params[:id]
    @name = params[:name] if params[:name]
    @speciality = params[:speciality] if params[:speciality]
  end
end

describe '.find' do
  context 'if nothing saved' do
    it 'returns nil' do
      expect(Doctor.find(1)).to eq nil
    end
  end
end

describe '#save' do
  before :all do
    @doctor = Doctor.new(
      name: 'Doctor',
      speciality: 'specialist'
    )
    @id = @doctor.save
  end

  it 'saves himself' do
    doctor = Doctor.find @id

    expect(doctor.name).to eq 'Doctor'
    expect(doctor.speciality).to eq 'specialist'

    expect(doctor).to eq @doctor
  end
end
