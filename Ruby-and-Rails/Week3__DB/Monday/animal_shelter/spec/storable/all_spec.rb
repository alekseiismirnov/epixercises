# frozen_string_literal: true

require 'date'
require_relative '../spec_helper.rb'

describe '.all' do
  context 'there are some saved objects' do
    before :each do
      @names = ('Name E'..'Name K').to_a
      @length = @names.length
      @specialities = ('specialist 1'.."specialist #{@length}")
      @names.zip(@specialities).each do |n, s|
        Mocktor.new(name: n, speciality: s).save
      end
    end

    it 'retrieves all of them corectly' do
      expect(Mocktor.all).to match_array(@names.zip(@specialities).map do |n, s|
                                          Mocktor.new(name: n, speciality: s)
                                        end)
    end
  end
end
