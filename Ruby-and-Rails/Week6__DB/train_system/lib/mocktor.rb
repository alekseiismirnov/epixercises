# frozen_string_literal: true

require_relative './storable.rb'
require_relative './related.rb'

# Doctor, but lives only in test db
class Mocktor
  include Storable
  include Related

  assign_table :mocktors
  assign_columns %i[name speciality]

  assign_related :faketients

  attr_reader :id, :name, :speciality

  def initialize(params)
    params = Hash[params.map { |k, v| [k.to_sym, v] }]

    @id = params[:id].to_i if params[:id]
    @name = params[:name] if params[:name]
    @speciality = params[:speciality] if params[:speciality]
  end
end
