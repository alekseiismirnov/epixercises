# frozen_string_literal: true

require_relative './storable'
require_relative './related'

class Stop
  include Storable
  include Related

  assign_table :stops
  assign_columns %i[minutes]

  assign_related :cities, :trains

  attr_reader :id, minutes

  def initialize(params)
    params = params.transform_keys(&:to_sym)

    @id = params[:id].to_i if params[:id]
    @minutes = params[:minutes].to_i if params[:minutes]
  end

  def city
    cities.first
  end

  def train
    trains.first
  end
end
