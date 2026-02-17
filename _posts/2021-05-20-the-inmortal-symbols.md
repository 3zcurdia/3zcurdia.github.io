---
layout: post
title: The inmortal symbols
description: What Ruby's garbage collector will never clean
date: "2021-05-20T18:00:00-06:00"
tags:
  - ruby
---

#### TL;DR;
> Always validate the names of the allowed methods when performing metaprogramming.

In Ruby, it's very common to use symbols for almost everything, as they are more efficient for searches and comparisons than simple strings. And thanks to the garbage collector, we don't have to worry about the memory allocations used by our symbols. However, there's a scenario where the garbage collector ignores them and enables "immortal symbols." These symbols will never be removed by the garbage collector and will live in memory forever. Let's run a small test. We'll use ObjectSpace for practical purposes, and in this case, we'll focus only on symbols and strings.

The execution yields the following result

```ruby
require 'objspace'
require 'SecureRandom'

puts ObjectSpace.count_objects.slice(:T_SYMBOL, :T_STRING)

10.times { SecureRandom.hex.to_sym }

puts ObjectSpace.count_objects.slice(:T_SYMBOL, :T_STRING)

GC.start

puts ObjectSpace.count_objects.slice(:T_SYMBOL, :T_STRING)
```

As we can see at the beginning, we have several strings and symbols. When we call `SecureRandom.hex`, we instantiate a string, and then it's converted into a symbol. Since neither is used, the garbage collector removes these symbols and some other strings.

Now, let's assume we have some metaprogramming in our code, for which we'll use `method_missing`, `send`, and `define_method`.

```ruby
require 'objspace'
require 'SecureRandom'

puts ObjectSpace.count_objects.slice(:T_SYMBOL, :T_STRING)

class Inmortal
  def method_missing(method, *args, &block)
    create_method(method)
    send(method)
  end

  def create_method(name)
    self.class.define_method(name) { "method_#{name}/0" }
  end
end

my_inmortal = Inmortal.new

10.times { my_inmortal.send(SecureRandom.hex) }

puts ObjectSpace.count_objects.slice(:T_SYMBOL, :T_STRING)

GC.start

puts ObjectSpace.count_objects.slice(:T_SYMBOL, :T_STRING)
```

Y tenemos como resultado

```shell
$ ruby inmortal.rb
{:T_SYMBOL=>28, :T_STRING=>10107}
{:T_SYMBOL=>38, :T_STRING=>10179}
{:T_SYMBOL=>28, :T_STRING=>7787}
```

What happened here? When we generated 10 new symbols that we never generated before. To debug, we'll add `method_missing`.

```ruby
   def method_missing(method, *args, &block)
    puts method.class
    create_method(method)
    send(method)
  end
```

and now this happens

```shell
{:T_SYMBOL=>28, :T_STRING=>10135}
Symbol
Symbol
Symbol
Symbol
Symbol
Symbol
Symbol
Symbol
Symbol
Symbol
{:T_SYMBOL=>38, :T_STRING=>10144}
{:T_SYMBOL=>38, :T_STRING=>7793}
```

Okay, apparently `method_missing` is receiving a symbol, okay, but who is sending it? Let's investigate inside the `send` method.

```ruby
  def send(method, *args, &block)
    puts method.class
    super
  end
```

and we have

```shell
$ ruby inmortal.rb
{:T_SYMBOL=>28, :T_STRING=>10152}
String
Symbol
String
Symbol
String
Symbol
String
Symbol
String
Symbol
String
Symbol
String
Symbol
String
Symbol
String
Symbol
String
Symbol
{:T_SYMBOL=>38, :T_STRING=>10164}
{:T_SYMBOL=>38, :T_STRING=>7794}
```

Therefore, the `send` method is called twice: first as a string, and then the `method_missing` method is called and converted back to a symbol. This makes sense, as the documentation states:

> Send: Invokes the method identified by symbol, passing it any arguments specified. When the method is identified by a string, the string is converted to a symbol.

Okay, we've determined what gets converted to symbols, but why doesn't the garbage collector ever remove those symbols?

Let's delve deeper. If we modify our test to examine the methods defined in our class, we'll get more detailed information.

```ruby
puts my_inmortal.methods.count
10.times { my_inmortal.send(SecureRandom.hex) }
puts my_inmortal.methods.count
```

and we will get

```shell
$ ruby inmortal.rb
{:T_SYMBOL=>28, :T_STRING=>10134}
60
70
{:T_SYMBOL=>38, :T_STRING=>10228}
{:T_SYMBOL=>38, :T_STRING=>7793}
```

As we can see, our class instance has 10 new method definitions that are symbols; therefore, the garbage collector ignores these references since they belong to an object instance. Even if the object instance is completely deleted, the references to that object's methods remain forever.

So, how can we avoid these memory leaks? Simply by avoiding the creation of unwanted methods.

```ruby
require 'objspace'
require 'SecureRandom'

puts ObjectSpace.count_objects.slice(:T_SYMBOL, :T_STRING)

class Inmortal
  def method_missing(method, *args, &block)
    super unless method.start_with?('m_')
    create_method(method)
    send(method)
  end

  def respond_to_missing?(method, include_private = false)
    method.start_with?('m_') or super
  end

  def create_method(name)
    self.class.define_method(name) { "method_#{name}/0" }
  end
end

my_inmortal = Inmortal.new

10.times { my_inmortal.send("m_#{SecureRandom.hex}") }
10.times { my_inmortal.send(SecureRandom.hex) rescue nil }

puts ObjectSpace.count_objects.slice(:T_SYMBOL, :T_STRING)

GC.start

puts ObjectSpace.count_objects.slice(:T_SYMBOL, :T_STRING)
```

Resulting in something like this

```shell
$ ruby inmortal.rb
{:T_SYMBOL=>28, :T_STRING=>10145}
{:T_SYMBOL=>48, :T_STRING=>10204}
{:T_SYMBOL=>38, :T_STRING=>7805}
```

As we can see, when we validate both `respond_to_missing` and `method_missing`, we prevent the creation of a new method. Therefore, there will be no "immortal" symbols, only those required for the instance.

Basically, you could create a memory bomb in Ruby by doing something like this.

```ruby
require 'SecureRandom'

class Bomb
  def method_missing(meth, *args, &blk)
    self.class.send(:define_method, "is_#{meth}?") { true }
    send("is_#{meth}?")
  end
end

loop { Bomb.new.send(SecureRandom.hex) }
```

So now you know, be careful with the use of symbols when doing metaprogramming.
