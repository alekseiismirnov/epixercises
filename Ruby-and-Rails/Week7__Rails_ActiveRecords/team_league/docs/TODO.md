# Team League #

Create an app to manage a league with teams and tournaments.

## Scenarios ##

- [x] As the *league manager*, I want to add, update, delete and list **teams**.

- [x] As the *league manager*, I want each **team** to have a **team coordinator** so I have a single point of contact for that team.

- [x] As the *team coordinator*, I want to add, update, delete and list **players** on my team so I can keep track of who is currently on it.

## Styling ##

- [x] Roughly desing and create layout
- [x] Consider what could be done for the existings views:

teams
: edit.html.erb  index.html.erb  new.html.erb  show.html.erb

games
: new.html.erb

players
: edit.html.erb  new.html.erb

tournaments
: new.html.erb show.html.erb

## Further Exploration ##

- [x] As the *league manager*, I want to set up **games** between teams so I can keep track of *scores* and *win-loss records*.
- [x] As the *league manager*, I want to generate a **tournament** that pits the top **teams** against each other based on their records.
  - [x] Tournament relation;
  - [x] Checkboxes test;
  - [x] Form;
  - [x] Tournament page test;
  - [x] Tournament page.
- [x] Make it looks descent.

(Hint: Pick an even number like 8 or 16 so every team in the tournament always has a match.)

## Issues ##

- [x] Why `team_id` in `games`? By mistke.  There is no already.
