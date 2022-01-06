# Design Notes #

## Tech Recommendations ##

- There is a many-to-many relationship between cities and trains.  ```Storable``` and ```Related``` lib seems to be a natural solution.
- When you list out the trains for a specific city, you'll need to start by selecting all stops for that city, and then selecting all trains for those stops.

## Tech Spec ##

There is a many-to-many relationship between cities and trains.

`Train`: id, number as string.
`City`: id, name

`Stops`: id, delay in minutes

`cities_stops`, `stops_trains`

Views for all CRUD functions for *trains* and *cities*.  

Lists for *trains* and *cities* are with links to objects.

Views for *trains* and *cities* contain lists of related objects.

No authentifiction, header with menu for all.

## Questions ##

- [x] "To purchase a ticket", what does is it mean? Just select destination, press button, and get confirmation.
  - [x] Dates? (Date pickers in **Further Exploration**) Same as above, but select a date first.
- [x] How to add multiply related objects? At ones or one by one?  With checkboxes? One by one. On second stage with ```<select>```
- [x] Do we need to maintain a stops order and how if do? No.
- [x] Where to put time each train stops in each city?
  - [x] Make class like `Related` which can handle additional column in the cross-table? When correspondent function returns array of related objects paired with values.

## Almost the same ##

- Test data generators and specs.
