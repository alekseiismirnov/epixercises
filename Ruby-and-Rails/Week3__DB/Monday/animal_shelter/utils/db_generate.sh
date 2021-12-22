#!/bin/sh
dropdb animal_shelter

createdb animal_shelter

psql animal_shelter <<ESQL
\c animal_shelter;

-- ---
-- Table 'animals'
-- 
-- ---

DROP TABLE IF EXISTS animals;
		
CREATE TABLE animals (
  id serial PRIMARY KEY,
  name VARCHAR ,
  gender VARCHAR ,
  admittance DATE
);

-- ---
-- Table 'breeds'
-- 
-- ---

DROP TABLE IF EXISTS breeds;
		
CREATE TABLE breeds (
  id serial PRIMARY KEY,
  name VARCHAR 
);

-- ---
-- Table 'types'
-- 
-- ---

DROP TABLE IF EXISTS types;
		
CREATE TABLE types (
  id serial PRIMARY KEY,
  name varchar
);

-- ---
-- Table 'customers'
-- 
-- ---

DROP TABLE IF EXISTS customers;
		
CREATE TABLE customers (
  id serial PRIMARY KEY,
  name VARCHAR ,
  phone VARCHAR
);

-- ---
-- Table 'animals_breeds'
-- 
-- ---

DROP TABLE IF EXISTS animals_breeds;
		
CREATE TABLE animals_breeds (
  id serial PRIMARY KEY,
  animal_id INTEGER ,
  breed_id INTEGER
);

-- ---
-- Table 'animals_types'
-- 
-- ---

DROP TABLE IF EXISTS animals_types;
		
CREATE TABLE animals_types (
  id serial PRIMARY KEY,
  animal_id INTEGER ,
  type_id INTEGER
);

-- ---
-- Table 'breeds_customers'
-- 
-- ---

DROP TABLE IF EXISTS breeds_customers;
		
CREATE TABLE breeds_customers (
  id serial PRIMARY KEY,
  customer_id INTEGER ,
  breed_id INTEGER
);

-- ---
-- Table 'customers_types'
-- 
-- ---

DROP TABLE IF EXISTS customers_types;
		
CREATE TABLE customers_types (
  id serial PRIMARY KEY,
  type_id INTEGER ,
  customer_id INTEGER
);

-- ---
-- Table 'animals_customers'
-- 
-- ---

DROP TABLE IF EXISTS animals_customers;
		
CREATE TABLE animals_customers (
  id serial PRIMARY KEY,
  animal_id INTEGER ,
  customer_id INTEGER
);
ESQL

dropdb animal_shelter_test
createdb -T animal_shelter animal_shelter_test
