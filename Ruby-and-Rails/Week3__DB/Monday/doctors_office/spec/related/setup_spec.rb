# frozen_string_literal: true

require_relative '../spec_helper.rb'

describe '.assign_related' do
  it 'adds related ' do
    expect(Doctor.we_know_it?('patients')).to eq true
    expect(Doctor.name_crosstable(Patient.new(name: 'Whatever'))).to eq 'doctors_patients'

    doctor = Doctor.new(name: 'Whoknows')
    expect(doctor.respond_to?(:patients)).to be true
    expect(doctor.column_names(Patient.new(name: 'Whatever'))).to eq 'doctor_id, patient_id'
  end
end
