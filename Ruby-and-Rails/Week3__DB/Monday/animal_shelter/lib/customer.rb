# frozen_string_literal: true

require_relative './storable.rb'
require_relative './related.rb'

class Customer
  include Storable
  include Related

  assign_table :customers
  assign_columns %i[name phone]

  assign_related :breeds, :types

  attr_reader :id, :name, :phone

  def initialize(params)
    params = Hash[params.map { |k, v| [k.to_sym, v] }]

    @id = params[:id].to_i if params[:id]
    @name = params[:name] if params[:name]
    @phone = params[:phone] if params[:phone]
  end

  # wrong design consequenses:
  def breed
    breeds.first.name
  end

  def type
    types.first.name
  end
end
