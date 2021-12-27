# TODO #

## Model ##

- [x] Database scheme
  - [x] List of storable classes
  - [x] List relations and cross-tables
- [x] DB generation scripts and DBs
- [x] Transfer CRUD mixin modules with tests from the ```doctors_office```. See ```storable_filelist.txt``` for complete list.
  - \lib (storable.rb, related.rb, mocktor.rb, and faketient.rb)
  - \spec (\storable,\related, and spec_helper),
  - \utils (dbgen_mocktors.sh, dbgen_faketient_crosstable.sh) and rename 'birthate' field.
  - [x] modify spec_helper
- [x] Implement classes
- [x] Implement tests and views
  - [x] Modyfy spec_helper.rb
  - [x] Add an animal.  Type and breed - by id.
  - [x] Add a customer.  Type and breed - again by id.
  - [x] Make test data.
  - [x] Customer view, separated pages:
    - [x] View animals by the breed, sorted by the name.
    - [x] View animals by the type, sorted by the name.
    - [x] View all animals sorted by the name.
  - [x] View all animals sorted by the admittance, older - first
  - [x] View customers by the breed preferance
  - [x] Add animal to the customer.

## Further Exploration ##

- [x] Add images and css to improve the user experience on your pages.
- [ ] Explore HTML and Bootstrap options for forms and fields.
- [ ] Add the ability for the shelter to assign volunteers or foster parents to specific animals.
