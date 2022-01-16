# Train System #

- [ ] Make a program to map a train system. Trains will stop in a number of cities and each city may have a number of trains coming through it.
- [ ] Final code review:
  - [ ] Does the database use standard naming convention for both columns and tables?
  - [ ] Is the many-to-many relationship set up correctly?
  - [ ] Is CRUD functionality being executed in class methods and routes?
  - [ ] Do routes correctly follow RESTful convention?
  - [ ] Does the application work as expected?

## Goals ##

- [ ] It should allow train system **operators** to add, update and delete information.
- [ ] It should allow train **riders** to read information regarding when and where they can ride a train.

## User Stories ##

### Operator ###

- [ ] As a train system operator, I want to create, read, update, delete and list trains, so that I can track all of the trains in my system.
- [ ] As a train system operator, I want to create, read, update, delete and list cities where my trains will stop, so that I can manage where all of the trains will go.

### Rider ###

- [ ] As a train rider, I want to view a train, so that I can see the cities where it stops.
- [ ] As a train rider, I want to view a city, so that I can see which trains come to it.
- [ ] As a train rider, I want to see a timetable that shows what time each train stops in each city.
- [ ] As a train rider, I want to purchase a ticket in a particular city for a particular train so that I can get on and off in any city that train travels. (This can work like a MAX ticket where you are able to purchase the ticket independent of the destination).

## Research ##

- [x] Tasks from the `To learn 1st` at the `Learning Notes`.
- [x] Clarify the project description and update this TODO
  
## Game Plan ##

### First Approach ###

- [x] Design DB scheme.  Two main tables and one cross-tabe.
- [x] Generate db and tables for the project and for the `Storable`-`Related`.
- [x] Transfer `Storable` and `Related` with tests and views.
- [x] Make classes.
- [x] Put somewhere time each train stops in each city and make corrections...
  - [x] Stop-time will be stored in the `stops` table
    - [x] Make corrections in DB scheme: add `stops`: id, delay, `cities_stops`, and `stops_trains`
    - [x] Re-create database accordingly.
    - [x] Make `Stop` class.
- [x] Make test data generator.
- [x] Make CRUD tests and pages, for trains and cities
  - [x] List and object views for trains and cities.
  - [x] Add 'Delete' button to items in lists.
  - [x] Input forms.  Redirect to lists after creation.
  - [x] Update forms. Redirect to object view.
- [x] Add `related` functionality to city and train views.
  - [x] Learn partials, see `Learning notes`.
  - [x] Add the fild, which accepts listst of id's in:
    - [x] Train create form.
    - [x] Train update form.
  - [x] Add list of *cities* in the train view and list of trains in the *city* view.
- [ ] Add `Buy ticket' option on city view page, redirecting on a 'ticket' page.

## Further Exploration ##

- [ ] Tasks from the `Further Exploration` at the `Learining Notes`.
- [ ] Rewrite `related` lists member to use JOIN in more effective way, if it's possibje.
- [ ] Replace input multiply id's field with multiselection ones.
- [ ] Date picker instead of input field for the date in `Buy ticket` form.
- [ ] Add navbar, header and footer to the `layout.erb`.
- [ ] Add images: logo, trains and cities pics in object views.
- [ ] Add Bootstrap styling.
