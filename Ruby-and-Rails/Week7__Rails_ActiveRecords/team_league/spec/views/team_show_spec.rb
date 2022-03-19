describe('Show Team', type: :feature) do
  before :each do
    @team_headless = Team.create(name: 'Drum Team')
    @team = Team.create(name: 'Golden Fly')
    @team.create_coordinator(name: 'Choosen One', contacts: 'Arroyo 12')
  end

  it 'shows team name' do
    visit(team_path(@team_headless))
    expect(find('h1').text).to eq 'Team Drum Team'
  end

  it 'shows team coordinator data' do
    visit(team_path(@team))
    within '#coordinator' do
      expect(page).to have_content 'Name: Choosen One'
      expect(page).to have_content 'Contacts: Arroyo 12'
    end
  end
end
