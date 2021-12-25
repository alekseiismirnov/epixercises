# frozen_string_literal: true

require_relative '../spec_helper.rb'

describe('View animals by the breed, sorted by the name.', type: :feature) do
  before :all do
    class SnakePot
      attr_reader :customers_names, :breed_homefly
    end

    shelter = SnakePot.new

    @breed = shelter.breed_homefly
    @names = shelter.customers_names[0, 5]
  end

  it 'shows sorted list of names by customers with particular breed preferences' do
    visit "/breeds/#{@breed.id}/customers"
    expect(page.status_code).to eq 200

    within('.customers_list') do
      expect(all('.customer').map(&:text)).to eq @names
    end
  end
end
