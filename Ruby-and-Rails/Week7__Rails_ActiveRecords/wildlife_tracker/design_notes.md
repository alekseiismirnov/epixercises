# Desighn Notes #

## Models ##

### Animal ###

* `@species`
  
has many sightings

### Sighting ###

* `@animal`
* `@location` (latitude, longtitude)

has one region
has one animal

### Region ###

* `@name`

has many sightings
