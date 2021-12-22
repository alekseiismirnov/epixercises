#!/bin/sh

psql animal_shelter_test <<ESQL
\c animal_shelter_test;
CREATE TABLE mocktors 
  (id serial PRIMARY KEY, name varchar, speciality varchar);
ESQL
