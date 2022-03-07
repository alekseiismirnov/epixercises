# Design notes #

## Models ##

### Player ###

@name

belongs to **team**

### Team ###

@name

has many **players**
has one **team_coordinator**

### TeamCoordinator ###

@name

belongs to **team**
