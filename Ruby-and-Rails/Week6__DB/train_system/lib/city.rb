# frozen_string_literal: true

require_relative './storable'
require_relative './related'

class City
  include Storable
  include Related

  assign_table :cities
  assign_columns %i[name]

  assign_related :trains, :stops

  attr_reader :id, :name

  def initialize(params)
    params = params.transform_keys(&:to_sym)

    @id = params[:id].to_i if params[:id]
    @name = params[:name] if params[:name]
  end

  def delete
    stops.each(&:delete)

    super
  end
end
