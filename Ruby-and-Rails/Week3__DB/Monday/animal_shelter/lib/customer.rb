# frozen_string_literal: true

require_relative './storable.rb'
require_relative './related.rb'

class Customer
  include Storable
  include Related

  assign_table :customers
  assign_columns %i[name phone]

  assign_related :breeds, :types

  attr_reader :id, :name, :gender, :admittance

  def initialize(params)
    @id = params[:id].to_i if params[:id]
    @name = params[:name] if params[:name]
    @admittance = params[:phone].to_i if params[:phone]
  end
end
