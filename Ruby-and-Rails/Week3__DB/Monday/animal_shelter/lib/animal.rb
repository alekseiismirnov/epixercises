# frozen_string_literal: true

requre_relative './storable.rb'
requre_relative './related.rb'

class Animal
  include Storable
  include Related

  assign_table :animals
  assign_fields %i[name gender admittance]

  assign_related :breeds, :types

  attr_reader :id, :name, :gender, :admittance

  def initialize(params)
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
