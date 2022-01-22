# Learning Notes #

## To Learn 1st ##

### SQL ###

- [x] ```LIKE``` and ```ILIKE```
- [x] Ordering results
- [x] Limiting results
- [x] PostgreSQL Tutorial
  - [x] Further on quering  
  - [x] Filtering
  - [x] Joining tables.  Мракобєсіє.
- [x] Theory: ACID

`ON DELETE CASCADE` deletes record with foreign key if key is deleted:

```sql
ALTER TABLE cities_stops 
  ADD CONSTRAINT cities_stops_city_id_fkey 
  FOREIGN KEY (city_id) 
  REFERENCES cities(id) ON DELETE CASCADE;
```

### Rake ###

- [x] Basic operations
- [x] Database backup/restore

## Front ##

- [x] Form for the button f.e. 'Delete'
  - `form`, action - url, method - post or get
  - `input` with type "hidden", name "_method", and value "delete"
  - button type - "submit"
- [x] Capybara find element after the text.
  - for my items lists `within(find('<.item_class>', text='<whatever>'))` is enouth.

### Sinatra ###

`request.path_info` - path of the last request.

- [x] Render partials in erb:

`<%= erb :linked_list %>`

### Further Exploration ###

- [x] HTML selection. `select`:
  
```erb
       <select class="form-select" id="cities" name="city_id">
        <% @cities.each do |city| %>
          <option value="<%=city[:id]%>"><%=city[:name]%></option>
        <% end %>
```
  
- [x] SQL JOIN for `related` lists. - Already, actually.
- [x] HTML or Bootstrap date picker.
  - `input`: type="date"
- [x] Refresh Bootstrap grid enogh for this project.
  Structure seems to be very simple.

## Question ##

- Check what we get, when we fetch non-string data from the DB.
- How to initialize ```@table``` in ```Storable``` without calling a function in derevative class?  Not in module definition, not in ```module ClassMethods```, not it ```class << self```.
