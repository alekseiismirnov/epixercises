# frozen_string_literal: true

require_relative './storable.rb'
require_relative './related.rb'

class Speciality
  include Storable
  include Related

  assign_table :specialities
  assign_columns %i[speciality]

  assign_related :doctors

  attr_reader :id, :speciality

  def initialize(params)
    params = Hash[params.map { |k, v| [k.to_sym, v] }]

    @id = params[:id].to_i if params[:id]
    @speciality = params[:speciality] if params[:speciality]
  end
end
