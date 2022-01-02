psql train_system_test<<ESQL
\c train_system_test;
CREATE TABLE faketients
  (id serial PRIMARY KEY, name varchar, birthdate date);

CREATE TABLE mocktors 
  (id serial PRIMARY KEY, name varchar, speciality varchar);
  
CREATE TABLE faketients_mocktors
  (id serial PRIMARY KEY, faketient_id int, mocktor_id int);
ESQL
