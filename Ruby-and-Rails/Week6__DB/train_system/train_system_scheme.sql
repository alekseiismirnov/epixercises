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

CREATE TABLE stops (
 id BIGSERIAL,
 minutes INTEGER
);


ALTER TABLE stops ADD CONSTRAINT stops_pkey PRIMARY KEY (id);

CREATE TABLE stops_trains (
 id BIGSERIAL,
 train_id INTEGER,
 stop_id INTEGER
);


ALTER TABLE stops_trains ADD CONSTRAINT stops_trains_pkey PRIMARY KEY (id);

CREATE TABLE cities_stops (
 id BIGSERIAL,
 stop_id INTEGER,
 city_id INTEGER
);


ALTER TABLE cities_stops ADD CONSTRAINT cities_stops_pkey PRIMARY KEY (id);

ALTER TABLE stops_trains ADD CONSTRAINT stops_trains_train_id_fkey FOREIGN KEY (train_id) REFERENCES trains(id);
ALTER TABLE stops_trains ADD CONSTRAINT stops_trains_stop_id_fkey FOREIGN KEY (stop_id) REFERENCES stops(id);
ALTER TABLE cities_stops ADD CONSTRAINT cities_stops_stop_id_fkey FOREIGN KEY (stop_id) REFERENCES stops(id);
ALTER TABLE cities_stops ADD CONSTRAINT cities_stops_city_id_fkey FOREIGN KEY (city_id) REFERENCES cities(id);