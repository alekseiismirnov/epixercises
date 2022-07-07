require 'rails_helper'

feature 'Tournament Page' do
  before :each do
    league = HighLowLeague.new
    @teams_names = league.teams_names
    @teams_order = league.teams_order
  end

  scenario 'Manager visit new tournament page' do
    visit '/tournaments/new'
    expect(page).to have_http_status(:success)

    @teams_names.each do |name|
      check name
    end

    click_button 'Submit'
    expect(page).to have_http_status(:success)
    expect(Tournament.count).to eq 1

    ordered_names = @teams_order.map { |i| @teams_names[i] }
    expect(all('.round__team').map(&:text)).to eq ordered_names
  end
end
