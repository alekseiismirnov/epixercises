# frozen_string_literal: true

require_relative '../spec_helper.rb'

describe('Adopt animal', type: :feature) do
  before :all do
    SnakePot.new

    @animal = Animal.all.first
    @customer = Customer.all.first
  end

  it 'adds the customer to the animal' do
    visit "/animals/#{@animal.id}/assign_customer"
    expect(page.status_code).to eq 200

    within('.form_add') do
      expect(page).to have_content 'Customer ID'

      fill_in 'customer_id',	with: @customer.id
      click_button 'Add'
      expect(page.status_code).to eq 200

      expect(@animal.customer).to eq @customer
    end
  end
end
