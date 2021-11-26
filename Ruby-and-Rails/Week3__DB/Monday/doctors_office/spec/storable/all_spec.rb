# frozen_string_literal: true

require 'date'
require_relative '../spec_helper.rb'

class Doctor
  include Storable

  assign_table :doctors
  assign_columns %i[name speciality]

  attr_reader :id, :name, :speciality

  def initialize(params)
    params = Hash[params.map { |k, v| [k.to_sym, v] }]

    @id = params[:id] if params[:id]
    @name = params[:name] if params[:name]
    @speciality = params[:speciality] if params[:speciality]
  end
end

describe '.all' do
  context 'there are some saved objects' do
    before :each do
      @names = ('Name E'..'Name K').to_a
      @length = @names.length
      @specialities = ('specialist 1'.."specialist #{@length}")
      @names.zip(@specialities).each do |n, s|
        Doctor.new(name: n, speciality: s).save
      end
    end

    it 'retrieves all of them corectly' do
      expect(Doctor.all).to match_array(@names.zip(@specialities).map do |n, s|
                                          Doctor.new(name: n, speciality: s)
                                        end)
    end
  end
end
