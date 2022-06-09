# Design notes #

## Models ##

### Player ###

@name

belongs to **team**

### Team ###

@name

has many **players**
has one **team_coordinator**

### TeamCoordinator ###

@name

belongs to **team**

### Game ###

#scores(game_id)
@scores
@winner_id

```ruby
class Game < ApplicationRecord
  has_and_belongs_to_many :teams
end
```

```ruby
create_table :games
  t.column(scores:, :integer)
  t.column(:team, :foreign_key {to_table: :team})
```

```ruby
  class Team < ApplicationRecord
    has_and_belongs_to_many :games
  end
```-

OR

```ruby
class Game < ApplicationRecord
  belongs_to :winner, class_name: 'Team', foreign_key: 'winner_id'
  belongs_to :loser, class_name: 'Team', foreign_key: 'loser_id'
end
```

## Tournament ##

### View ###

```erb
<div id="round">
  <div id="match">
   <div id="first_team">
   <div id="second_team">
...
```

New tournament calls a form with 8 selectors for teams and submit button.
