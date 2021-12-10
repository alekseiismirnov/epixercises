#!/bin/sh

psql doctors_office_test <<ESQL
\c doctors_office_test;
ALTER TABLE faketients 
  RENAME COLUMN birthate TO birthdate;
ESQL