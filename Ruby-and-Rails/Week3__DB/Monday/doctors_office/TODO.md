# Doctor's Office #

## Overview ##

This program is for office administrators to track patients in a doctor's office.

Here are some user stories to get started:

- [x] As an administrator, I want to add a doctor to the database with a name and specialty.
- [x] As an administrator, I want to add a patient with their name and birthdate.
- [x] As an administrator, I want to be able to assign a patient to a doctor for care. \
      (Hint: Doctors will have a **one-to-many** relationship with their patients.)
- [x] As a doctor, I want to see the list of patients that have been assigned to me.

Now the doctor's office has been grown to include many doctors with the same specialty.
The doctors have organized themselves into specialty groups.

- [x] So when an administrator wants to enter a doctor,
      they must first select a specialty group and then add a doctor.

- [x] As a patient, I want to see a list of all the doctors in a particular specialty. A doctor will only have one specialty.
(Hint: change from storing specialty as a column to making a specialties table.)

- [x] As an administrator, I want to view an alphabetical list of doctors
      including the number of patients they see.
      (Hint: Do some online research for SQL ORDERing and COUNTing.)

## Required ##

- [x] Database - simple shell script
- [x] General class for models - might be challanging. We'll use JSON style hashes from DB.exec, as argument for constructors and do all conversion inside of them.
- [x] Tests for classes and classes iself - m.b. would be no need to test REST functionality, having tested generall class and integration test
- [x] Integration tests - done, if we make all stubs
- [x] Views and routes - done when all of them done.

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

- Classes ```Doctor```, ```Speciality``` have a lot of in common:
  
```ruby
require_relative './storable.rb'
require_relative './related.rb'

class <<<Class_Name>>>
  include Storable
  include Related

  assign_table :<<<table>>>
  assign_columns %i[<<<columns names>>>]

  assign_related :<<<related>>>

  attr_reader :id, <<<* other attributes>>>

  def initialize(params)
    params = Hash[params.map { |k, v| [k.to_sym, v] }]

    @id = params[:id].to_i if params[:id]
    @<member> = params[:<<<member>>>] if params[:<<<member>>>]
  end
end
```

##### General Views #####

We can make classes for representations.  Later, next project probably.

### Backend tests and classes iself ###

- [x] CRUD functionality
- [x] Doctor - patient interaction

### Integration tests with Views and routes ###

#### Initial version ####

- [x] Administrator
  - [x] Create a doctor
    - [x] Test on backend, we were not asked for doctor/s page or so
    - [x] Universal create form...
  - [x] Create a patient
  - [x] Assign a patient to a doctor
    - "Edit" page seems not to be a good place
    - For the test purpose we can make a generally useless page with one field and button, just for the proof of the concept.
    - We can add a doctor's id, not user friendly, but quick
    - And check on the "update" page if it added, then assign
- [x] Doctor
  - [x] To list the patients, assigned to the doctor

#### Version for The Grown Office ####

- [x] Change from storing specialty as a column to making a specialties table
  - [x] DB transition:
    - [x] Make table 'specialities' with 'speciality' and 'doctor_id'. Remove column 'speciality' from 'doctors'
    - [x] Modify tests.  There are 11 ones. **8 of them** only because of using one part of the code to test another one.  Actually ```Doctor``` class. See ```tests_fallen_after_specialities_transition.txt```.
      - [x] Make ```Mocktor``` class and apropriate table. Only in test db obviously.
      - [x] And ```Faketient``` and ```faketient_mocktor``` table
      - [x] Change all tests for ```Storable``` and ```Related```.
  - [x] Add 'Speciality' class.
  - [x] Add relation to the ```Doctror``` and ```Doctor#speciality```.  In fact, that last one is only ```#specialities.first.speciality```
- [x] Patient
  - [x] To list doctors by speciality
    - [x] Move the link to the new doctor add form to the speciality page. This is a consequence of an ill design.
    - [x] Add doctors list to the group page.
    - [x] Kind of an universal list.
- [ ] Administrator
  - [x] Add a doctor from the speciality group page
  - [x] To list alphabetically doctors along with the number of assigned patients
    - [x] Do some online research for SQL ORDERing and COUNTing.  Can be done way more quickly without it.  And it's rather harmfull kind of an optimisation: [The largest percentage of U.S. medical practices in 2018 included practices with **2-5 physicians**, representing over 23 percent of the total. Medical practices with **31-100 physicians** represented around 11 percent of medical practices in the United States in that year.](https://www.statista.com/statistics/415971/size-of-medical-practices-in-the-us/#statisticContainer) And how often admin will request this dats?

    - [x] So we have to find a right place for the SQL query, which returns an ordered pairs object(doctors)-numbers
      - [?] make parametric ```all``` or add an additional  parmeter processing to the ```search```
      - [?] obtain and process a complicated result: objects with additional numbers.
      - [?] this kind of search obviously access data from ```Storable``` and ```Related```.
      - [?] directly to the ```Doctor```
      - [?] make a new mixin module
      - [ ] put it to the ```Related``` which depends on ```Storable``` anyhow.
        - [x] Add ```Related.default_report```, argument is the symbolic name of related in plural.
    -[x] Add the view.
