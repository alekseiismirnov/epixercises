require 'date'
require_relative './storable.rb'

class Patient
  include Storable

  assign_table :patients
  assign_columns %i[name birthdate]

  attr_reader :id, :name, :birthdate

  def initialize(params)
    params = Hash[params.map { |k, v| [k.to_sym, v] }]

    @id = params[:id].to_i if params[:id]
    @name = params[:name] if params[:name]
    @birthdate = Date.parse(params[:birthdate]) if params[:birthdate]
  end
end
