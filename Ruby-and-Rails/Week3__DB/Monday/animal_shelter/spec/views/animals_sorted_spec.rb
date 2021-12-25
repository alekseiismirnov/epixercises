# frozen_string_literal: true

require_relative '../spec_helper.rb'

describe('View animals sorted.', type: :feature) do
  before :all do
    class SnakePot
      attr_reader :snakes_data, :flies_data
    end

    shelter = SnakePot.new

    @names = (shelter.snakes_data + shelter.flies_data)
             .sort { |this, other| Date.parse(other[:admittance]) <=> Date.parse(this[:admittance]) }
             .map { |record| record[:name] }
  end

  it 'shows list of animals names, sorted by admittance' do
    visit '/animals/sort_by_admittance'
    expect(page.status_code).to eq 200

    within('.animals_list') do
      expect(all('.animal').map(&:text)).to eq @names
    end
  end
end
