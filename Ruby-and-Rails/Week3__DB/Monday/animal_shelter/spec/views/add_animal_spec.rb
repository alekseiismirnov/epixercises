# frozen_string_literal: true

require_relative '../spec_helper.rb'

describe('Add an animal page', type: :feature) do
  before :each do
    @breeds = %w[Drosophila Howerfly Housefly]
              .map { |name| Breed.new(name: name) }
    @breeds.each(&:save)

    @types = %w[fly ant spectre]
             .map { |name| Type.new(name: name) }
    @types.each(&:save)

    @animals_data = [
      { 'name' => 'Fido', 'admittance' => '1 Jan 1988', 'gender' => 'M', 'type' => @types[0].id, 'breed' => @breeds[1].id },
      { 'name' => 'Ajie', 'admittance' => '1 Jan 1992', 'gender' => 'F', 'type' => @types[0].id, 'breed' => @breeds[2].id }
    ]
  end
  binding.pry
  it 'allows to add new animal to database' do
    animals = @animals_data.map { |record| Animal.new record }

    visit '/animals/new'
    expect(page.status_code).to eq 200

    within('.form_new') do
      @animals_data.each do |record|
        visit '/animals/new'
        expect(page.status_code).to eq 200
        record.each do |field, value|
          fill_in field.to_sym, with: value
        end

        click_button 'Add'
        expect(page.status_code).to eq 200
      end

      expect(Animal.all).to match_array animals

      # Storable#== does not work for all members, you remember
      # not test the case when breeds and types are swaped
      expect(Animal.all.map(&:breed)).to match_array %w[Howerfly Housefly]
      expect(Animal.all.map(&:type)).to eq ['fly'] * 2
    end
  end
end
