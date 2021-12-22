# frozen_string_literal: true

require_relative './storable.rb'
require_relative './related.rb'

class Animal
  include Storable
  include Related

  assign_table :animals
  assign_columns %i[name gender admittance]

  assign_related :breeds, :types

  attr_reader :id, :name, :gender, :admittance

  def initialize(params)
    params = Hash[params.map { |k, v| [k.to_sym, v] }]

    @id = params[:id].to_i if params[:id]
    @name = params[:name] if params[:name]
    @admittance = Date.parse(params[:admittance]) if params[:admittance]
  end

  # wrong design consequenses:
  def breed
    breeds.first.name
  end

  def type
    types.first.name
  end
end
