# frozen_string_literal: true

require_relative './storable.rb'
require_relative './related.rb'

class Doctor
  include Storable
  include Related

  assign_table :doctors
  assign_columns %i[name]

  assign_related :patients, :specialities

  attr_reader :id, :name

  def initialize(params)
    params = Hash[params.map { |k, v| [k.to_sym, v] }]

    @id = params[:id].to_i if params[:id]
    @name = params[:name] if params[:name]
  end

  def speciality
    specialities.first.speciality
  end
end
