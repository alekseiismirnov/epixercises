describe('routes for Teams', type: :routing) do
  it 'routes /teams to the index controller' do
    expect(get('/teams')).to route_to('teams#index')
  end

  it 'routes /teams/team to the show controller' do
    expect(get('/teams/team')).to route_to(
      controller: 'teams',
      action: 'show',
      id: 'team'
    )
  end

  it 'routes to new team form' do
    expect(get('/teams/new')).to route_to(
      controller: 'teams',
      action: 'new'
    )
  end

  it 'routes post /teams' do
    expect(post('/teams')).to route_to('teams#create')
  end

  it 'routes /teams/team/edit' do
    expect(get('/teams/team/edit')).to route_to(
      controller: 'teams',
      action: 'edit',
      id: 'team'
    )
  end

  it 'routes update for team' do
    expect(patch('/teams/team')).to route_to(
      controller: 'teams',
      action: 'update',
      id: 'team'
    )
  end

  it 'routes delete for team' do
    expect(delete('/teams/team')).to route_to(
      controller: 'teams',
      action: 'destroy',
      id: 'team'
    )
  end
end
