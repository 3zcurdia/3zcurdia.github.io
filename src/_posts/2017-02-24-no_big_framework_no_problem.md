---
layout: post
title: "No big framework, No problem"
date: "2017-02-24T11:19:04-06:00"
tags:
  - programming
  - design patterns
---

Recently you might face the need to learn a new frontend framework, and last year you had to do the same. Unfortunately, this is a very common practice among web developers, spending too much time during the learning curve for a technology that won't be using in their next job. A pure javascript solution is not very sexy, but with the right architecture, any developer can be productive since the first day. Here are the patterns that I found very useful to clean up my frontend code, without the need of many dependencies.

This is not a vanilla javascript solution, but that never stopped you right?

# CoffeeScript is your friend

[CoffeeScript](http://coffeescript.org/) is a little language that compiles into JavaScript, allowing you to write less code and safer. If you are a Ruby on Rails developer, you might be familiar with it. However, I found that outside the rails community is not that common. Maybe some javascript puritans will refute the idea of drinking coffee in their codebase, but for mere mortals, it is a very tasteful solution.

<img class="img-fluid" src="/assets/media/code-maintenance.png" alt="code-maintenance">

The idea of writing less code is not enough; you need some structure, and here is where CoffeeScript turns very handy. You can do object-oriented programming, by building classes more clearly and intuitive.

{% highlight coffeescript linenos %}
class Monkey
  constructor: (selector) ->
    @element = $(selector)
    @name = @element.data('name')
    @bindEvents()

  bindingEvents: () ->
     @element.on 'click', @speak

  speak: (e) =>
     alert "My name is #{@name}"

$(document).ready ->
  new Monkey('.monkey') if $('.monkey').length
{% endhighlight %}

As you might see is easier to understand what your class is doing and also allows you to encapsulate your code within the scope of the class. Following this pattern, you will have the freedom to do whatever you want within your class.

# Services

Instead of having your string endpoints spread across all the javascript why we don't reorganize in one place that describes better what we are doing. Let's say we have a RESTful architecture to consume it, you only need a base class that can be reused on each endpoint.

{% highlight coffeescript linenos %}
window.LeftMonkey ||= {}
class LeftMonkey.BaseService
  constructor: () ->
    @base_url = ""

  index: () ->
    $.ajax(method: 'get', url: @base_url)

  show: (id) ->
    $.ajax(method: 'get', url: "#{@base_url}/#{id}")

  create: (data) ->
    $.ajax(method: 'post', url: "#{@base_url}/", data: data)

  update: (id, data) ->
    $.ajax(method: 'put', url: "#{@base_url}/#{id}", data: data)

  delete: (id) ->
    $.ajax(method: 'delete', url: "#{@base_url}/#{id}")
{% endhighlight %}

Having this base class now you can extend the object for each endpoint as a separated service.

{% highlight coffeescript linenos %}
class LeftMonkey.MonkeyService extends LeftMonkey.BaseService
  constructor: () ->
    @base_url = '/api/v1/monkeys/'
{% endhighlight %}

And if you have nested routes you can do this

{% highlight coffeescript linenos %}
class LeftMonkey.ZooMonkeyService extends LeftMonkey.BaseService
  constructor: (id) ->
    @base_url = "/api/v1/zoo/#{id}/monkeys/"
{% endhighlight %}

## Template views

Writing HTML in javascript, it feels wrong and sometimes gets too messy especially when you try to define a complex rendering. As many MVC or MVVM frontend frameworks handle it with a js template, the easiest to use is [Handlebars](http://handlebarsjs.com/). Similar to Mustache but with extendable support helpers, it allows us to perform complex rendering logic in a similar way as our backend templates.

 {% highlight html linenos %}
<div class="zoo">
  <h1>{ { name } } </h1>
  <ul class="animal_list">
    { {#each animals } }
    <li>{ { { name } } }</li>
    { {/ each } }
  </div>
</div>
{% endhighlight %}
If we create our templates within our asset pipeline, the only required dependency will be the handlebars-runtime, and it only weights `34 kb`. Awesome!

## Controllers

Finally, our last piece of the puzzle is the controller. An abstraction that allows us to control the behavior of the entire view. This abstraction layer will connect the templates with the services and the events for the rendered views

{% highlight coffeescript linenos %}
class ZooController
  constructor: (selector) ->
    @element = $(selector)
    @service = new LeftMonkey.ZooService(@element.data('id'))
    @template = HandlebarsTemplates['zoo']
    @fetch()

  fetch: () ->
    @service.index().done (data) =>
      @zoo = data.zoo
      @render()

  render: () ->
    @element.html @template(zoo: zoo)
    @bindEvents()

  bindEvents: () ->
    for animal in @zoo.animals
      if animal.kind is 'monkey'
        new Monkey('.animal_list .animal.monkey')

$(document).ready ->
  new Monkey('#zoo') if $('#zoo').length
{% endhighlight %}

This layer can easily get messy, to avoid that you must ask yourself if the new logic belongs to the controller responsibility or to a new object.

## Conclusion

As you can see in a few lines of code, we implement a pseudo-framework that will help us to organize our frontend in an easy way. A little bit more complicated than a regular function, but in the long term, it will help you to move out some rendering computing from the backend, without the need of a larger framework.
