psql animal_shelter_test<<ESQL
\c animal_shelter_test;
CREATE TABLE faketients
  (id serial PRIMARY KEY, name varchar, birthdate date);

CREATE TABLE faketients_mocktors
  (id serial PRIMARY KEY, faketient_id int, mocktor_id int);
ESQL
