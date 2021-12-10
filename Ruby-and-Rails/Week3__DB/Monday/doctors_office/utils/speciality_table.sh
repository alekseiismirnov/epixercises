#!/bin/sh

psql doctors_office <<ESQL
\c doctors_office;
CREATE TABLE specialities
  (id serial PRIMARY KEY, speciality varchar);

CREATE TABLE doctors_specialities
  (id serial PRIMARY KEY, doctor_id int, speciality_id int);

ALTER TABLE doctors
  DROP speciality;

\c doctors_office_test;
CREATE TABLE specialities
  (id serial PRIMARY KEY, speciality varchar);

CREATE TABLE doctors_specialities
  (id serial PRIMARY KEY, doctor_id int, speciality_id int);

ALTER TABLE doctors
  DROP speciality;

ESQL