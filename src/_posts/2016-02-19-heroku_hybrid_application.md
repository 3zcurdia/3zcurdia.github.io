---
layout: post
title: "Heroku hybrid application with Go and Ruby"
description: "How to make a Go application with sprockets"
date: "2016-02-19T18:39:29-06:00"
tags:
  - ruby
  - go
  - code
  - deploy
  - heroku
---

As a ruby developer I like how easy and convenient is to have an asset pipeline, specially when your frontend gets larger or complex. Serve fewer and smaller files is a good practice on web development, however the best tool(that I know) for asset pipeline is sprockets, and is really hard to build from scratch an asset pipeline handler with compression and minification. Instead of reinvent the wheel, lets use it.
<!--more-->

## Configuring standalone sprockets

I could configure sprockets to work standalone from scratch, but instead the ``sprockets-standalone`` gem will simplify the process, just by adding an small rakefile.

{% highlight ruby linenos %}
require 'sprockets/standalone'

Sprockets::Standalone::RakeTask.new(:assets) do |config, sprockets|
  config.assets   = %w(javascripts/application.js stylesheets/application.css *.jpg *.png)
  config.sources  = %w(assets vendor/assets)
  config.output   = File.expand_path('../public', __FILE__)
  config.compress = false
  config.digest   = false

  sprockets.js_compressor  = :uglifier
  sprockets.css_compressor = :scss
end

namespace :assets do
  desc 'Alias for Compile assets'
  task precompile: :compile
end
{% endhighlight %}

The `config.assets` specify the files with the manifest and the file extensions to deliver on the pipeline. The `config.sources` defines root directory for all assets.

{% highlight ruby linenos %}
config.assets  = %w(javascripts/application.js stylesheets/application.css *.jpg *.png)
config.sources = %w(assets vendor/assets)
{% endhighlight %}

To keep it simple, the web application wont use digest on the filenames, for that reason the `config.digest` it will be disabled.

{% highlight ruby linenos %}
config.digest = false
{% endhighlight %}

`uglifier` and `sass` are the default gems to compress the assets, but it can change at your convenience.

{% highlight ruby linenos %}
sprockets.js_compressor  = :uglifier
sprockets.css_compressor = :scss
{% endhighlight %}

`rake assets:precompile` it will be called by the heroku ruby buildpack, an alias to `compile` will work fine.

{% highlight ruby linenos %}
namespace :assets do
  desc 'Alias for Compile assets'
  task precompile: :compile
end
{% endhighlight %}

This simple configuration it enables the assets (pre)compilation like any other ruby application.

## Go web application layout

The Go application now could be asset agnonstic, therefore the application wont care about the assets, and it will only call them from the public directory. An easy way to configure a template is by using the package render.

{% highlight go lineos %}
package main

import (
  "net/http"
  ...
  "github.com/unrolled/render"
  ...
)

func main() {
  r := render.New(render.Options{
    Layout: "layout",
  })

  ...

  mux.GET("/", func(w http.ResponseWriter, req *http.Request) {
    r.HTML(w, http.StatusOK, "index", nil)
  })
  ...
}
{% endhighlight %}

And just by adding simple html tags in the layout will call the compiled assets

{% highlight html linenos %}
<link rel="stylesheet" type="text/css" href="/stylesheets/application.css" />
<script src="/javascript/application.js" type="text/javascript"></script>
{% endhighlight %}

## Dynamic assets compilation

In a local environment we need a fast, easy and reliable way to get the last changes with a simple refresh, however in a compiled languages this is not an easy task, you need to recompile every time you made a change. Jeremy Saenz has provide a tool for the Go community called [gin](https://github.com/codegangsta/gin) witch listen changes on our code, compile and serve automatically. Gin is a great tool for code but not for assets, this is where [gawp](https://github.com/martingallagher/gawp) is the perfect match, because as gin work for code gawp do the same but fully configurable.

The `.gawp` file is very easy to configure, just by adding a regular expression for the files to listen and command steps to execute, once is triggered.

**.gawp**
{% highlight bash linenos %}
recursive: true
verbose: false
workers: 4
write, create, rename:
  (?i)[a-z]+\.(scss|css|coffee|js):
  - rake assets:compile

create:
  .*:
  - echo created $file
remove:
  .*:
  - echo removed $file
{% endhighlight %}

this line is going to listen the events (write, create or rename) for any asset in our project and then it will trigger the rake task

{% highlight bash linenos %}
write, create, rename:
  (?i)[a-z]+\.(scss|css|coffee|js):
  - rake assets:compile
{% endhighlight %}

With this tool we also could automate the code compilation for the project.

## Deploy to heroku

To create a heroku project with Go and ruby buildpacks,
4 simple steps will do the job:

1. Create the heroku repo with the Go buildpack

        heroku create -b https://github.com/kr/heroku-buildpack-go.git

2. Add the ruby buildpack for assets compilation with sprockets

        heroku buildpacks:add heroku/ruby

3. Include the Go dependecies into the project directory

        godep save ./...

4. Git push and heroku will do the rest

## Conclusion

This is just a way to use the best from two worlds, from ruby we got the georgeous organization for assets,
and from Go we got the speed and the small memory footprint in our application.

## TL;DR

If you rather to read code than extensive explanations checkout the template I made [here](https://github.com/3zcurdia/go-web-template)
