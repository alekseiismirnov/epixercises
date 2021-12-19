psql doctors_office <<ESQL
\c doctors_office_test;
CREATE TABLE faketients
  (id serial PRIMARY KEY, name varchar, birthdate date);

CREATE TABLE faketients_mocktors
  (id serial PRIMARY KEY, faketient_id int, mocktor_id int);
ESQL
