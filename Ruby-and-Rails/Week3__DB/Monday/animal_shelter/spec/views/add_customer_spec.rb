# frozen_string_literal: true

require_relative '../spec_helper.rb'

describe('Add an customer page', type: :feature) do
  before :each do
    @breeds = %w[Drosophila Howerfly Housefly]
              .map { |name| Breed.new(name: name) }
    @breeds.each(&:save)

    @types = %w[fly ant spectre]
             .map { |name| Type.new(name: name) }
    @types.each(&:save)

    @customers_data = [
      { 'name' => 'Common Name', 'phone' => '2222837460101', 'type' => @types[2].id, 'breed' => @breeds[0].id },
      { 'name' => 'Who Knows', 'phone' => '50041984740505', 'type' => @types[2].id, 'breed' => @breeds[2].id },
    ]
  end

  it 'allows to add new customer to database' do
    customers = @customers_data.map { |record| Customer.new record }

    visit '/customers/new'
    expect(page.status_code).to eq 200

    within('.form_new') do
      @customers_data.each do |record|
        visit '/customers/new'
        expect(page.status_code).to eq 200
        record.each do |field, value|
          fill_in field.to_sym, with: value
        end

        click_button 'Add'

        expect(page.status_code).to eq 200
      end

      expect(Customer.all).to match_array customers

      # Storable#== does not work for all members, you remember
      # not test the case when breeds and types are swaped
      expect(Customer.all.map(&:breed)).to match_array %w[Drosophila Housefly]
      expect(Customer.all.map(&:type)).to eq ['spectre'] * 2
    end
  end
end

