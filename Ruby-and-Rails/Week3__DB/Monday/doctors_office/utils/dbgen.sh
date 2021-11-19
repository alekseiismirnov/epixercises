#!/bin/sh

createdb doctors_office

psql doctors_office <<ESQL
\c doctors_office;
CREATE TABLE doctors 
  (id serial PRIMARY KEY, name varchar, speciality varchar);

CREATE TABLE patients
  (id serial PRIMARY KEY, name varchar, birthate date, id_doctor int);
ESQL

createdb -T doctors_office doctors_office_test
