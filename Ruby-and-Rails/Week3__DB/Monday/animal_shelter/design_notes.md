# Design Notes #

## Storable classes ##

- Animal [name, gender, date of admittance]
- Customer [name, phone].
- Breed [name]
- Type [name]

I see now two problems with such design:

- ```Storable#==%``` ignores breed and type.
- We have to save storable object before the adding breed and type.

### Relations ###

 A customer should have an animal type preference, and a breed preference.  Customer related to breeds and types.

animals_types
customers_types
animals_breeds
customers_breeds

  As a shelter worker, I want to add an owner to an animal
  if that customer adopts, so Animal releted to Customer.

animals_customers

## Almost the same ##

Type and Breed classes are identical.

Atributes readers should be implemented in ```Storable``` by default.

Also ```@table``` initialization. See Learning Notes.

```params = Hash[params.map { |k, v| [k.to_sym, v] }]``` in all ```initialize```'s
