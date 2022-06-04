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
