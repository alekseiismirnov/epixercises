# Questions #

If there is no answer in the task, I'll try to mimic product owner.

## On desighn ##

- [x] Should **team coordinator** be a **player**?  **No.** It's not a part of the task, but they do not have overlapped responsibilities.
- [x] Should **team coordinator** belong to more then one team? **No**, because of possible conflict of interests.
- [x] What properties should **team coordinator** have?  Obviously name and contacts.  No need to make separate fields for the phone or e-mail, it would be just a text field with the all avaiable info.
- [x] How we accoutn scores? No draws, team either get scores or not.
- [ ] Game model 
  - [x] What about @date ? **Not yet**.
  - [x] It refers on exactrly two teams, shoudl we use has_many relation? **No.  Do not know why should be.**
  - [x] What about this scheme? Team has_many games and game belongs_to team, and has_one team, another of course.  Initalization process seems to be complicated, but we can add corresponden game to the both teams at ones... Or not... Would it work at all for Rails standard relationship declaration?  Two same `#team`. **Not functional**
  - [x] `have_and_belong_to_many` works well, but how we could determine who is a winner? Indeed, who get the scores for the game. Only to keep separate winners team id. 
  
  ```ruby
  class Game < ApplicationRecord
    belongs_to :winner, class_name: 'Team', foreign_key: 'winner_id'
  ```

  - [x] Win-loss, how to do it exactly? #winner and #looser perhaps? Yes.
  - [x] Do we need only create and retrive functionalty? Yes.  For the beginning.

## So, on the tournament table ##

Task says: As the league manager, I want to generate a tournament that pits the top teams against each other based on their records. (Hint: Pick an even number like 8 or 16 so every team in the tournament always has a match.)

- [x] Whould it be right to sort all teams by scores and and just pair first with second, third with forth etc? Yes
- [x] Shoud we generate a table only for the first round? Yes, it will have a practical sence for a minimal cost.
- [x] What should we printout?  Teams names and scores.
- [x] We delete teams, what we have to do with the correspondent game?  Logically, it would be right not to delete team at all and turn it into a kind of a 'zombie' team.  Or make a reserch on situation when we need to delete a team, but in first approach we would just *delete a correspondent game*.  We do not keep a separate win-lose and score records, thus data associated with the deleted game will be lost.  I have no idea how to write `dependent: :destroy` from aliased model, so gonna do this explicetly. 
- [x] Should be the pair of teams in tournament be the game? No.  This is a kind of pre-game.

## On Tournament Desighn ## 

- [x] It seems to be a class with an array? Yes.  Otherwise we have to define variables from `team1_id` to `team8_id` or so.
- [x] How to deal with arrays in active records?  `serialize :teams_ids`
- [x] Simple, but ugly as for me.  Could it be a relation? Seems so, we can keep teams ids long with the weigt, but I don't know how.
- [x] Could this weight be a scores? No, scores could be equal, thus we could get different teams combination with the next request.
- [x] Is there an association? As for me, it looks like `:has_many_and_belongs_to_many`,but I see no way how to keep an order in this case. No.
- [x] So, what now?  Keep an array of `team_id`.
- [x] How to get an array from a form? Checkboxes.
