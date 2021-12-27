# frozen_string_literal: true

require_relative './storable.rb'
require_relative './related.rb'

class Volonteer
  include Storable
  include Related

  assign_table :volonteers
  assign_columns %i[name]

  attr_reader :id, :name

  def initialize(params)
    params = Hash[params.map { |k, v| [k.to_sym, v] }]

    @id = params[:id].to_i if params[:id]
    @name = params[:name] if params[:name]
  end
end
