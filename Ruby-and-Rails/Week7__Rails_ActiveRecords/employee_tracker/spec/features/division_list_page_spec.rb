require 'rails_helper'
require 'joy_division_helper'

feature 'Division CRUD' do
  before :all do
    @company = JoyDivision.new
  end

  scenario 'HR Manager lists divisions' do
    visit divisions_path
    expect(page).to have_http_status(:success)
    within('.divisions') do
      expect(all('.divisions__division').map(&:text)).to match_array @company.divisions_names
    end
  end
end
