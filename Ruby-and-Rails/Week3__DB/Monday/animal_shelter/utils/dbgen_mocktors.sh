#!/bin/sh

psql doctors_office <<ESQL
\c doctors_office_test;
CREATE TABLE mocktors 
  (id serial PRIMARY KEY, name varchar, speciality varchar);
ESQL
