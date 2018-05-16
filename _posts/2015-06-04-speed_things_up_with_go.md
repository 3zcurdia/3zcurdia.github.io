---
layout: post
title: "Speed things up with Go"
description: "A use case with go and concurrency to improve speed"
date: "2015-06-04T22:22:27-05:00"
background: /assets/images/post-bg.jpg
tags:
  - ruby
  - go
---

I am always been fascinated about speed, from overclocking hardware to efficient algorithms, but I always struggle with compiled programming languages and concurrency, I remember my early days as a developer shooting my foot with this concepts. <!--more-->For compiled programming languages I used to say: "well this binary is fast enough I don't  need more speed"; or for scripting languages: "Hey! it only runs once, I dont need to speed things up". But then I got involved on web applications development I found that **speed matters**. If you have a latency greater than a second, your users will start to complain, so is better to be fast.

<blockquote class="blockquote-reverse">
  Nobody complains if you make your code faster
</blockquote>

### I just want pretty badges <i class='fa fa-trophy'></i>
While I was building this site I wanted to have a pretty styled badges from my github account, but I could not found any service that I liked. So I decide to build my own badge system to pull from my github repositories statistics to present them nicely. The problem was simple fetch your repositories, get the programming languages on each one of them and add it into a single hash. Very simple, right?

<blockquote class="blockquote-reverse">
  The first solution isn't always best
</blockquote>

### First Aproach
On my first approach I build it through javascript using async ajax calls, but I found that there is a limit on request on the api, to avoid that you need to use an oauth token to extend your hourly quota, and also the loading wasn't good enough, the badges were popping after the page was loaded, so I decide to move forward building a small service with a javascript plugin.

<blockquote class="blockquote-reverse">
  When in doubt benchmark
</blockquote>

### Experimentation and Second Aproach
Although the ruby algorithm was extremely simple, it took me around 15 seconds to fetch all my repositories languages in less than 20 lines of code, it looks a good example to benchmark against go.

Coming from an object oriented paradigm where everything is an object, it took me a while to consume the RESTful API because contrary to javascript, when you pull a json data on Go you need to specify what do you want to use instead expect that the language parse into an object by itself. Another problem that I found and not very unpleasant was that I needed to write more code, but once I got solved the problem the performance improvement was 4x faster than ruby. I did a great job but I still wasn't happy 4[s] is not fast enough for a web service and the solution still was 2x slower than the javascript async version.

### Optimization
I figured out that the latency was caused by the secuence on api calls, if I had 20 repositories and each request took me around 185[ms] well there is my bottleneck. So I decided solve this using **concurrency** for that I had to implement another get method using channels, instead returning a value and fetch each repository language using go rutines, the result was fantastic, the whole process took less than a second. **I MADE IT!!**

<div id="badges" class="text-center"></div>

### TL;DR
Concurrency in Go is painless, but you will have to be more declarative and write more code.

If you want to check the project just visit [here](http://getbadger.herokuapp.com) or keep on eye on the [code](https://github.com/3zcurdia/badger)

<br/>

<script type="text/javascript">
  $(document).ready(function(){
    $('#badges').badger({username: "3zcurdia", remote_style: false});
  });
</script>
