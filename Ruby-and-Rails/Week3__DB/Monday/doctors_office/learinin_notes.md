# Assorted Notes #

## Database Backup ##

Example for PostgreSQL, database name ```database_name```

Backup:

```pg_dump database_name > database_backup.sql```

Restore:

```bash
create_db database_name
psql database_name < database_backup.sql
crete_db -T database_name database_name_test
```

### Methastuff ###

Set instance variable by its symbol name:

```ruby
  instance_variable_set(:@name, "What Ever")
```

Maybe there is less clumsy method to make it from the variable, but I don't know yet:

```ruby
  member_ref = "@#{member_name}".to_sym
```

Create class methods from module:

```ruby
module ...
...
  class << self
    def included(base)
      base.extend ClassMethods
    end
  end

  module ClassMethods
    def assign_table(table)
      @table = table
    end
  end
...
end
```

Send message:

```public_send(symbolic_message_name, arguments)```

Catch message with method missing:

```ruby
  def respond_to_missing?(method_name, *args, &block)
    we_know_it?(method_name) || super
  end

  def method_missing(method_name, *args, &block)
    super unless we_know_it? method_name
    #TODO
  end
```

Check ```expect(doctor.respond_to?(:patients)).to be true```

Get a class by its name: ```Object.const_get '<class name>'```

## Question ##

- Where to put type convertors from strings?  At call to .new or inside the constructor?

- Check what we get, when we fetch non-string data from the DB.

## To Learn ##

Seems not so long:

- [ ] Ruby libs handling
- [x] Markdown. Just have a reference card would be enough.

Long:

- [ ] Ruby methaprogramming
