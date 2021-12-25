# frozen_string_literal: true

require_relative '../spec_helper.rb'

describe('View animals by the breed, sorted by the name.', type: :feature) do
  before :all do
    class SnakePot
      attr_reader :type_fly, :flies_data
    end

    shelter = SnakePot.new

    @type = shelter.type_fly
    @names = shelter.flies_data.map { |record| record[:name] }.sort
  end

  it 'shows sorted list of names by animals with particular breed' do
    visit "/types/#{@type.id}/animals"
    expect(page.status_code).to eq 200

    within('.animals_list') do
      expect(all('.animal').map(&:text)).to eq @names
    end
  end
end
