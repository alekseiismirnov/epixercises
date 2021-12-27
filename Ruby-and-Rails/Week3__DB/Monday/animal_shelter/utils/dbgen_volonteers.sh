#!/bin/sh

psql animal_shelter_test<<ESQL
\c animal_shelter_test;

DROP TABLE IF EXISTS  volonteers;
CREATE TABLE volonteers
  (id serial PRIMARY KEY, name varchar);

DROP TABLE IF EXISTS animals_volonteers;
CREATE TABLE animals_volonteers
  (id serial PRIMARY KEY, animal_id int, volonteer_id int);

\c animal_shelter;

DROP TABLE IF EXISTS volonteers;
CREATE TABLE volonteers
  (id serial PRIMARY KEY, name varchar);

DROP TABLE IF EXISTS animals_volonteers;
CREATE TABLE animals_volonteers
  (id serial PRIMARY KEY, animal_id int, volonteer_id int);
ESQL
