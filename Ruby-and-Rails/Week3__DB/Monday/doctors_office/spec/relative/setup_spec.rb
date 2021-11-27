# frozen_string_literal: true

require 'date'
require_relative '../spec_helper.rb'

class Doctor
  include Related

  assign_related :patient

  attr_reader :id, :name, :speciality

  def initialize(params)
    params = Hash[params.map { |k, v| [k.to_sym, v] }]

    @id = params[:id] if params[:id]
    @name = params[:name] if params[:name]
    @speciality = params[:speciality] if params[:speciality]
  end
end

describe '.assign_related' do
  it 'adds related ' do
    class Doctor
      class << self
        attr_reader :related_tables, :relation_tables
      end
    end

    expect(Doctor.related_tables).to match_array [:patient]
    expect(Doctor.relation_tables).to match_array [:doctors_patients]
  end
end
