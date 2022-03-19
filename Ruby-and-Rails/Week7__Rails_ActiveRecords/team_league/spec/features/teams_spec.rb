require 'rails_helper'

feature 'teams CRUD' do
  before :each do
    @teams_names = HighLowLeague.new.teams_names
  end

  scenario 'League manager lists all teams', type: :request do
    visit '/teams'

    expect(page).to have_http_status(:success)
    within '#teams_list' do
      expect(all('#team_name').map(&:text)).to match_array @teams_names
    end
  end

  scenario 'League manager deletes team' do
    visit '/teams'

    within(find('#team', text: 'Team#5')) do
      click_on 'Delete'
    end
    expect(page).to have_http_status(:success)
    within '#teams_list' do
      expect(all('#team_name').map(&:text)).not_to include('Team#5')
    end
  end

  scenario 'League manager changes team name' do
    visit '/teams'
    within(find('#team', text: 'Team#3')) do
      click_on 'Edit'
    end
    expect(page).to have_http_status(:success)

    fill_in 'team_name', with: 'Wooden Team'
    click_button 'Change'
    within '#teams_list' do
      expect(all('#team_name').map(&:text)).not_to include('Team#3')
      expect(all('#team_name').map(&:text)).to include('Wooden Team')
    end
  end

  scenario 'League manager adds new team' do
    visit '/teams'
    click_on 'Add Team'
    expect(page).to have_http_status(:success)

    fill_in 'team_name', with: 'Something new'
    click_on 'Submit'
    expect(page).to have_http_status(:success)

    within '#teams_list' do
      expect(all('#team_name').map(&:text)).to include 'Something new'
    end
  end

  scenario 'League manager adds team coordinator' do
    team = Team.all.first
    visit "/teams/#{team.id}/coordinators/new"
    fill_in 'coordinator_name', with: 'Super Farmer'
    fill_in 'coordinator_contacts', with: 'Super Farm Far Far Away'

    click_button 'Add Coordinator'
    expect(team.coordinator.name).to eq 'Super Farmer'
    expect(team.coordinator.contacts).to eq 'Super Farm Far Far Away'
  end

  scenario 'League manager adds new, update, and delete player' do
    team = Team.all.first
    visit team_path(team)

    within '#players' do
      expect(page).to have_no_content 'Booba Kastorsky'
    end

    click_on 'Add Player'
    expect(page).to have_http_status(:success)
    fill_in 'player_name', with: 'Booba Kastorsky'
    click_button 'Add Player'
    expect(page).to have_http_status(:success)

    within '#player' do
      expect(page).to have_content 'Booba Kastorsky'
    end

    visit team_path(team)
    click_on 'Update Player'
    fill_in 'player_name', with: 'Claudio Abbado'
    click_button 'Update Player'

    within '#player' do
      expect(page).to have_content 'Claudio Abbado'
      expect(page).to have_no_content 'Booba Kastorsky'
    end

    visit team_path(team)
    click_on 'Delete'

    within '#players' do
      expect(page).to have_no_content 'Claudio Abbado'
      expect(page).to have_content 'No players yet'
    end
  end
end
