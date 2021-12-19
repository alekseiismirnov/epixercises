# frozen_string_literal: true

require 'date'
require_relative '../spec_helper.rb'

describe '#delete' do
  context 'there are some saved objects' do
    before :each do
      @names = ('Name E'..'Name K').to_a
      @length = @names.length
      @specialities = ('specialist 1'.."specialist #{@length}").to_a
      @ids = @names.zip(@specialities).map do |n, s|
        Mocktor.new(name: n, speciality: s).save
      end
    end

    it 'deletes only one, called on' do
      index = 4
      @names.delete_at index
      @specialities.delete_at index

      Mocktor.find(@ids[index]).delete

      expect(Mocktor.all).to match_array(@names.zip(@specialities).map do |n, s|
                                          Mocktor.new(name: n, speciality: s)
                                        end)
    end
  end
end
