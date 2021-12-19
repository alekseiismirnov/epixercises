# frozen_string_literal: true

requre_relative './storable.rb'
requre_relative './related.rb'

class Type
  include Storable
  include Related

  assign_table :types
  assign_fields :name

  assign_related :animals, :customers

  attr_reader :id, :name

  def initialize(params)
    @id = params[:id].to_i if params[:id]
    @name = params[:name] if params[:name]
  end
end
