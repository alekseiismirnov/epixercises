#!/bin/sh

psql doctors_office <<ESQL
\c doctors_office;
CREATE TABLE doctors_patients
  (id serial PRIMARY KEY, doctor_id int, patient_id int);

\c doctors_office_test;
CREATE TABLE doctors_patients
  (id serial PRIMARY KEY, doctor_id int, patient_id int);
ESQL