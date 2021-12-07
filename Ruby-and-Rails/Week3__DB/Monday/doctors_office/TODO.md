# Doctor's Office #

## Overview ##

This program is for office administrators to track patients in a doctor's office.

Here are some user stories to get started:

- [ ] As an administrator, I want to add a doctor to the database with a name and specialty.
- [ ] As an administrator, I want to add a patient with their name and birthdate.
- [ ] As an administrator, I want to be able to assign a patient to a doctor for care. \
      (Hint: Doctors will have a **one-to-many** relationship with their patients.)
- [ ] As a doctor, I want to see the list of patients that have been assigned to me.

Now the doctor's office has been grown to include many doctors with the same specialty.
The doctors have organized themselves into specialty groups.

- [ ] So when an administrator wants to enter a doctor,
      they must first select a specialty group and then add a doctor.

- [ ] As a patient, I want to see a list of all the doctors in a particular specialty. A doctor will only have one specialty.
(Hint: change from storing specialty as a column to making a specialties table.)

- [ ] As an administrator, I want to view an alphabetical list of doctors
      including the number of patients they see.
      (Hint: Do some online research for SQL ORDERing and COUNTing.)

## Required ##

- [x] Database - simple shell script
- [x] General class for models - might be challanging. We'll use JSON style hashes from DB.exec, as argument for constructors and do all conversion inside of them.
- [x] Tests for classes and classes iself - m.b. would be no need to test REST functionality, having tested generall class and integration test
- [ ] Integration tests - done, if we make all stubs
- [ ] Views and routes - done when all of them done.

### Databse ###

- [x] Tables for text and production
  - **doctors**: name, speciality
  - **patients**: name, birthdate, id_doctor

### General class for models ###

We can define operations for the list of fields and name of the table, all as symbols, stored in the class variables.  Descendanses can provide their own.  Actually done as mixin module ```Storable```.

- [x] #save
- [x] .find
- [x] == we'll not compare id's
- [x] .search
- [x] #update
- [x] .all
- [x] #delete
- [x] #add_related object and retrive

#### Add Related Object ####

For describing relation we can use another module, say ```Related```.  

No distinction yet on type of relations, everything is stored in a separate table, like with many-to-many type of relation.

We could call ```doctor.add_patient(patien)```.  Later we will need to establish doctors -- specialities relation, so we can't use generic function name, its name have to correspond to the related class.

We need a table name and from a ```patient``` we need only an id.  

Simple, but then we have to get all doctors patients and all doctors with the paritcular speciality...  

##### Here is the problem #####

We can get ids, we can have a related table, but we need a related class... So, seems it would look like this:

- [x] Somewhere, under the ~~rainbow~~ ```include Related``` will be a line ```assign_related :patient, :speciality```, from this one symbolic name we will make:
- [x] Relational table name.  Happily we already got a convention for such name: snake case, alphabeiticall order.
- [x] Function to add related object with apropriate name.  It could be one function for all related types, having naming standards, we can rely on object class name in argument.
- [x] Function to return all related objects
  - [x] We have to call somehow an apropriate constructor.

#### Almost The Same ####

Things, probably could be defined ones.

- How to add short attribute accessors to the members/columns?
- Parametric arguments processing.  Along with check if we receive particular parameter.
- How to set init in the Storable definition? There is a major problem: derivative class initializer should accept particular argument - hash with string keys, JSON style.
  - **Maybe make a function and call it from the initialize?** And then convert some members from the text to whatever.
  - [x] How to assing member, having its name as symbols?  Just in case, we have only getters.
- Select for which member/column we get data:

```ruby
  columns.reject { |column| params[column].nil? }
```

- Views and call to DB are terribly cumbersome, f/e ```Related#method_missing``` - select related.  Could it be done in more compact way?

### Backend tests and classes iself ###

- [x] CRUD functionality
- [x] Doctor - patient interaction

### Integration tests with Views and routes ###

#### Initial version ####

- [ ] Administrator
  - [ ] Create a doctor
    - [ ] Test on backend, we were not asked for doctor/s page or so
  - [?] Universal create form...
  - [ ] Create a patient
  - [ ] Assign a patient to a doctor
- [ ] Doctor
  - [ ] To list the patients, assigned to the doctor

#### Version for The Grown Office ####

- [ ] Change from storing specialty as a column to making a specialties table
- [ ] Patient
  - [ ] To list doctors by speciality
    - [?] Universal list ...
- [ ] Administrator
  - [ ] Access adding a doctor page from the speciality group page
  - [ ] To list alphabetically doctors along with the number of assigned patients
