# Design Notes #

## Storable classes ##

- Animal [name, gender, date of admittance]
- Customer [name, phone]. 
- Breed [name]
- Type [name]

### Relations ###

 A customer should have an animal type preference, and a breed preference.  Customer related to breeds and types.

animals_types
customers_types
animals_breeds
customers_breeds

  As a shelter worker, I want to add an owner to an animal
  if that customer adopts, so Animal releted to Customer.

animals_customers
