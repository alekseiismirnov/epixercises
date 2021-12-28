# Train System #

- [ ] Make a program to map a train system. Trains will stop in a number of cities and each city may have a number of trains coming through it.
- [ ] Final code review:
  - [ ] Does the database use standard naming convention for both columns and tables?
  - [ ] Is the many-to-many relationship set up correctly?
  - [ ] Is CRUD functionality being executed in class methods and routes?
  - [ ] Do routes correctly follow RESTful convention?
  - [ ] Does the application work as expected?

## Research ##

- [ ] Tasks from `To learn 1st` at `learning_notes.md`.
- [ ] Clarify the project description and update this TODO
  
## Goals ##

- [ ] It should allow train system **operators** to add, update and delete information.
- [ ] It should allow train **riders** to read information regarding when and where they can ride a train.
  
## Tech Recommendations ##

- [ ] There is a many-to-many relationship between cities and trains.  ```Storable``` and ```Related``` lib seems to be a natural solution.
- [x] You might consider naming the cities_trains join table stops to reflect the relationship between the two.  No. Do not compatible with ```Related``` lib.
- [ ] When you list out the trains for a specific city, you'll need to start by selecting all stops for that city, and then selecting all trains for those stops.

## User Stories ##

### Operator ###

- [ ] As a train system operator, I want to create, read, update, delete and list trains, so that I can track all of the trains in my system.
- [ ] As a train system operator, I want to create, read, update, delete and list cities where my trains will stop, so that I can manage where all of the trains will go.

### Rider ###

- [ ] As a train rider, I want to view a train, so that I can see the cities where it stops.
- [ ] As a train rider, I want to view a city, so that I can see which trains come to it.
- [ ] As a train rider, I want to see a timetable that shows what time each train stops in each city.
- [ ] As a train rider, I want to purchase a ticket in a particular city for a particular train so that I can get on and off in any city that train travels. (This can work like a MAX ticket where you are able to purchase the ticket independent of the destination).
