# Technical Interview Questions

1. *Why should we test our code before writing our methods?  What the purpose of having our tests falls before they pass?*  It's a test for a test, if it passes before method implementation, it definitely wrong.

2. *What is encapsulation?  Why it is so important in OOP?*  This is a part of a methodology among with the inheritance and polymorphism. Hiding object realization let us safely make changes in it. Dividing program on isolated parts makes design, implementation and testing much more convinient if possible at all.

3. *What is abstraction? How can we use abstraction for encapsulate a code?* Abstraction is a process of selecting parts of something relevant to the current context. Obviously it is a part of desighn process, which defines what should be acessible in implementation stage.  Rest part of the object we can encapsulate.

4. *What is class inheritance?  What are advantages and disadvantages of it?*  Class inheritance is a process of adding to the *parent* class additional properties. Obviously, it provides facility for the code reuse, but brokes encapsulation: making changes in _realization_ of the parent class we have to have in mind all its descendents.

5. *What is the difference between a class and a module?*  A module is just a collection of methods, don't has an `initialize` method and can't create objects like a class.

6. *What is the Enumarable module?  What are some of its most useful methods?  Demonstrate using a few.*  It's a collection of methods to work with collections.  It allows transform each element of it -- `map`, screen out, `reject`, and select, `select` elements with some properties, combine all elements -- `reduce`, and so on.  

```ruby
(1..5).map {|x| x**2}
(1..5).select(&:odd?)
(1..5).reject(&:odd?)
(1..5).reduce(&:+)
```

7. *What are `attr` methods?  What is the difference between a reader and a writer methods?  Come up with a few examples of when we wouldn't want to use a write method.*  This is just a simple way to allow a read and change protected by defauld attributes.  In general, set an attribute could be a simple way to realize a necessary method, but if, for example, we provide some authomatic indicator, we wouldn't like to have it changed voluntary.  
