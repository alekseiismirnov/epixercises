# frozen_string_literal: true

require_relative './storable'
require_relative './related'

class Train
  include Storable
  include Related

  assign_table :trains
  assign_columns %i[number]

  assign_related :cities, :stops

  attr_reader :id, :number

  def initialize(params)
    params = params.transform_keys(&:to_sym)

    @id = params[:id].to_i if params[:id]
    @number = params[:number] if params[:number]
  end

  def delete
    stops.each(&:delete)

    super
  end
end
