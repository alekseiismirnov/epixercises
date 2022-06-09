require 'rails_helper'

feature 'game setup' do
  before :each do
    HighLowLeague.new
  end

  scenario 'League manager sets up new game' do
    visit '/games/new'
    expect(page).to have_http_status(:success)

    select 'Team #2', from: 'game_winner_id'
    select 'Team #4', from: 'game_loser_id'
    fill_in 'game_scores',	with: '100500'
    click_button 'Submit'

    expect(page).to have_http_status(:success)
    expect(page).to have_content 'Game added'
    expect(Game.count).to eq 9
  end
end
