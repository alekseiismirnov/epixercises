# frozen_string_literal: true

require_relative '../spec_helper.rb'

describe('View animals by the breed, sorted by the name.', type: :feature) do
  before :all do
    class SnakePot
      attr_reader :breed_cobra, :cobras_names
    end

    shelter = SnakePot.new

    @breed = shelter.breed_cobra
    @names = shelter.cobras_names
  end

  it 'shows sorted list of names by animals with particular breed' do
    visit "/breeds/#{@breed.id}/animals"
    expect(page.status_code).to eq 200

    within('.animals_list') do
      expect(all('.animal').map(&:text)).to eq @names
    end
  end
end
