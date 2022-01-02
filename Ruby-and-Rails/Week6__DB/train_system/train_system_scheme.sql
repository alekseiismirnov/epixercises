CREATE TABLE trains (
 id BIGSERIAL,
 number VARCHAR
);


ALTER TABLE trains ADD CONSTRAINT trains_pkey PRIMARY KEY (id);

CREATE TABLE cities (
 id BIGSERIAL,
 name VARCHAR
);


ALTER TABLE cities ADD CONSTRAINT cities_pkey PRIMARY KEY (id);

CREATE TABLE cities_trains (
 id BIGSERIAL,
 train_id INTEGER,
 city_id INTEGER
);


ALTER TABLE cities_trains ADD CONSTRAINT cities_trains_pkey PRIMARY KEY (id);

ALTER TABLE cities_trains ADD CONSTRAINT cities_trains_train_id_fkey FOREIGN KEY (train_id) REFERENCES trains(id);
ALTER TABLE cities_trains ADD CONSTRAINT cities_trains_city_id_fkey FOREIGN KEY (city_id) REFERENCES cities(id);