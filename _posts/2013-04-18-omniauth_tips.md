---
layout: post
title: "Oauth Tips"
description: "5 tips to use oauth"
date: "2013-04-18T12:00:13-05:00"
background: /assets/images/post-bg.jpg
tags:
  - authentication
  - omniauth
  - ruby
---

As all we know oauth its one of the most popular methods to signup to many websites throught another 3rd patry services, and at this point probably you should know how to implement with [omniauth](https://github.com/intridea/omniauth) gem. But many times we encounter some problems durning the development of this fancy feature. Here are my recomendations
<!--more-->

## Secure your API Keys

Many times we push our code on open source repos without consider that other people (with bad intentions) could read it, so we do something like this

{% highlight ruby linenos %}
    Rails.application.config.middleware.use OmniAuth::Builder do
      provider :twitter, '611798630625', 'c699f703f247ee23ce447850'
    end
{% endhighlight %}

That is not too much dangerous to run and scream, just take the necesary precautions and set those variables inside the rails environment

{% highlight ruby linenos %}
    Rails.application.config.middleware.use OmniAuth::Builder do
      provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
    end
{% endhighlight %}

## Diferent Keys for Enviroments

The reason of that its because in some api providers like facebook doesn't support multiple callbacks in diferents urls, so I think it will be a good practice to do this

{% highlight ruby linenos %}
    Rails.application.config.middleware.use OmniAuth::Builder do
      provider :twitter, ENV[Rails.env]['TWITTER_KEY'], ENV[Rails.env]['TWITTER_SECRET']
    end
{% endhighlight %}

Yeah! I know its a lot of configuration, but that allow you to work and test with your 3rd Party provider better

## Google Apps vs Google Oauth2

Since everyone have a google account, everyone want to use it (thats because som users feel more confident to login through google instead a common social network like facebook or twitter). But which its the best solution?

### Google Apps

For groups who uses google apps, that is the easiest way:
Include the gem

{% highlight ruby %}
    gem 'omniauth-google-apps'
{% endhighlight %}

After you add the gem you will need to require some libraries on your omniauth initializer file

{% highlight ruby %}
    require 'openid/store/filesystem'
{% endhighlight %}


and because we dont need to create api keys you will use open id

{% highlight ruby %}
    provider :google_apps, store: OpenID::Store::Filesystem.new('/tmp'), domain: 'yourdomain.com'
{% endhighlight %}


and that will work for an specific domain name

### Google Oauth2
 For a regular gmail account, but
here we will need to add API keys... but where? Ok Go here and get some API keys for Oauth2  [https://code.google.com/apis/console](https://code.google.com/apis/console) and also dont forget to add some permissions for the google api's that you want to use.

The rest of the configurartion for omniauth its almost the same, but for the api use, that will be another show.
