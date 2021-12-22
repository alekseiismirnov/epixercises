# frozen_string_literal: true

require_relative './storable.rb'
require_relative './related.rb'

class Breed
  include Storable
  include Related

  assign_table :breeds
  assign_columns %i[name]

  assign_related :animals, :customers

  attr_reader :id, :name

  def initialize(params)
    params = Hash[params.map { |k, v| [k.to_sym, v] }]

    @id = params[:id].to_i if params[:id]
    @name = params[:name] if params[:name]
  end
end
