require 'rails_helper'
require 'joy_division_helper'

feature 'Division CRUD' do
  before :all do
    @company = JoyDivision.new
    @name_to_edit = 'ICQ'
    @correct_name = 'Jabber'
    @name_to_delete = 'Post-Sales'
    @new_division_name = 'Love & Care'
  end

  scenario 'HR Manager lists divisions' do
    visit divisions_path
    expect(page).to have_http_status(:success)
    within('.divisions') do
      expect(all('.divisions__division_link').map(&:text)).to match_array @company.divisions_names
    end
  end

  scenario 'HR Manager updates division name' do
    visit divisions_path
    within(find('.divisions__division', text: @name_to_edit)) do
      click_on 'Edit'
    end

    expect(page).to have_http_status(:success)
    fill_in 'division_name',	with: @correct_name
    click_on 'Submit'

    expect(page).to have_http_status(:success)
    expect(page).to have_no_text(@name_to_edit)
    expect(page).to have_text(@correct_name)
  end

  scenario 'HR Manager deletes division' do
    visit divisions_path
    within(find('.divisions__division', text: @name_to_delete)) do
      click_on 'Delete'
    end

    expect(page).to have_http_status(:success)
    expect(page).to have_no_text(@name_to_delete)
  end

  scenario 'HR Manager creates division' do
    visit divisions_path
    expect(page).to have_no_text(@new_division_name)
    click_on 'Add Division'

    expect(page).to have_http_status(:success)
    fill_in 'division_name', with: @new_division_name
    click_on 'Submit'

    expect(page).to have_http_status(:success)
    expect(page).to have_text(@new_division_name)
  end
end
