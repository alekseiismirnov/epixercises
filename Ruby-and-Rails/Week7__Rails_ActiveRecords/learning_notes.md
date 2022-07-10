# Week 7 Learning Notes #

## Objectives ##

* Databases with Models and Active Record
* Routes and Controllers
* Rake, a tool for running tasks
* Queries with Active
* Associations
* Validations
* Scopes
* shoulda-matchers
* 'require' shortcuts

## Keywords ##

MVC
Active Records & ORM

## RSpec ##

`rails generate rspec:install`



### Array test ###

```ruby
    expect(Animal.all.map(&:species)).to include 'Purple Frog'
    expect(Animal.all.map(&:species)).to_not include @animal_species
```

### HTTP Status ###

```ruby
expect(page).to have_http_status(:success)
```

### Test routes ###

```ruby
describe('routes for Teams', type: :routing) do
  it 'routes /teams to index controller' do
    expect(get('/teams')).to route_to('teams#index')
  end
end
```

## Databases with Models and Active Record ##

### Database ###

`gem 'pg'`

`rake db:create`

`rails g migration create_animals`

`rake db:migrate`

```ruby
t.column(:<name>, :<type>)
add_column(:<table>, :<name>, :<type>)
remove_column(:<table>, :<name>)
```

Foreign key.  

```ruby
add_column :<table>, :<column>_id, :integer
add_foreign_key :<what>, :<where>
```

```sh
rake db:migrate
rake db:test:prepare
rake db:rollback
```

`.delete` vs `.destroy`:

along with the `dependent: :destroy`

### PostgreSQL ###

Geometric data types.
`point`
<https://www.postgresql.org/docs/current/datatype-geometric.html#id-1.5.7.16.5>

```ruby
irb(main):007:0> a.sights.create(location: '0.001, 0.0002')
   (0.2ms)  BEGIN
  Sight Create (1.1ms)  INSERT INTO "sights" ("animal_id", "location") VALUES ($1, $2) RETURNING "id"  [["animal_id", 5], ["location", "(0.001,0.0002)"]]
   (2.3ms)  COMMIT
=> #<Sight id: 5, animal_id: 5, location: #<struct ActiveRecord::Point x=0.001, y=0.0002>>
```

### Models ###

```ruby
class Animal < ApplicationRecord
  has_many :sights, dependence: :destroy
end
```

## Routes and Controllers. And Views ##

### Routes ###

```ruby
Rails.application.routes.draw do
  root to: 'animals#index'

  resources :animals do
    resources :sights # , except: or only: [ ]
  end
end
```

### Create and Update ###

Controller:

```ruby
  ...
  def new
    @<object> = <Class>.new
    render :new
  end
...
```

Form:

```erb
<%= form_for @<object> do |f| %>
  <%= f.label :<field> %>
  <%= f.[text_field, text_area...] :<field> %>
  ...
  <% f.submit %>
<% end %>
```

Link:

```erb
<%= link_to '<text>', <route_prefix>_path[, data: {method: "<method>"}] %>
```

## Shoulda Matchers ##

`gem 'shoulda-matchers'`

```ruby
  Shoulda::Matchers.configure do |config|
    config.integrate do |with|
      with.test_framework :rspec
      with.library :rails
    end
  end  
```
