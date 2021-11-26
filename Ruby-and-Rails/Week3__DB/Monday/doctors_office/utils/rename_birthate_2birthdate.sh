#!/bin/sh


psql doctors_office <<ESQL
\c doctors_office;
ALTER TABLE patients
  RENAME COLUMN birthate TO birthdate;
ESQL

psql doctors_office_test <<ESQL
\c doctors_office_test;
ALTER TABLE patients 
  RENAME COLUMN birthate TO birthdate;
ESQL