# frozen_string_literal: true

require_relative '../spec_helper.rb'

describe '.assign_related' do
  it 'adds related ' do
    expect(Mocktor.we_know_it?('faketients')).to eq true
    expect(Mocktor.name_crosstable(Faketient.new(name: 'Whatever'))).to eq 'faketients_mocktors'

    doctor = Mocktor.new(name: 'Whoknows')
    expect(doctor.respond_to?(:faketients)).to be true
    expect(doctor.column_names(Faketient.new(name: 'Whatever'))).to eq 'faketient_id, mocktor_id'
  end
end
