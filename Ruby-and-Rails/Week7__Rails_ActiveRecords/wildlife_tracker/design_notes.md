# Desighn Notes #

## Models ##

### Animal ###

* `@name`
  
has many sightings

### Sighting ###

* `@animal`
* `@location` (latitude, longtitude)

has one region
has one animal

### Region ###

* `@name`

has many sightings
