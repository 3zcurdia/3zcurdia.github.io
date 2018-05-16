---
layout: post
title:  "Moving back to Jekyll!"
descrition: "Why I migrate from hugo"
date: 2018-05-15 20:48:03 -0500
background: /assets/images/post-bg.jpg
categories:
  - jekyll
  - case study
---

It has been a while since my last blog post, but before I start writing a new one, I need to do something.
Cleanup my current setup with [hugo](http://gohugo.io/). What was my suprise there a lot of things
that changed since the last update I made. And my current CI setup is not working.
Here are the 5 reasons I decide to move back to [jekyll](https://jekyllrb.com/)

## I do not post very often

As you might notice I am not a passionate writer therefore I got few pages to compile.
And even when hugo is blazing fast, I do not need that speed. In the worst case scenario
if my compilation will take more than 10 minutes, it wont make a difference in my personal site.

## Github pages are effordless

Since github introduced pages and simplify the integration with jekyll
the compilation to an static site from any other tool it will require
at least a deploy phase either to an s3 bucket or a `gh-pages` branch. Which complicates
the process for a simple blog.

## Jekyll project is stable

Even when hugo has reached an stable state and a great popularity within the golang community. I cannot percieve
the reach that Jeckyll community has. Maybe is thanks to ruby that allow an easy entry point for contributors through plugins and themes. Maybe is because the project has more years active than hugo. Maybe I am worng and the libaries, templates and documentation for hugo had reached the levels greather than Jeckyll. But I feel there is a lot of ground to cover.

## No CI needed

In my previous setup I loved the idea of a CI, however now is not working due a lot of changes within wrecker,
now is owned by Oracle and maybe my setup will not work. Maybe I could use another service
but using this methor will require compilation and deploy. And for a deploy I will need setup credentials,
and I dont want to spend a day or two trying to setup a CI to deploy a simple blog.

## I love ruby

Years ago I got a midlevel developer crisis, I felt that ruby was not good enough for my projects, so that was the time is when I learned go, and I liked. But after a while I missed the good ruby. Easier than any other programming language and the community has cover most of the common problems. So probably I will not need to write a plugin for something that I need, someone else has solved before me.

## Conclusion

Hugo is great, but sometimes you dont need a machine gun. Sometimes you need to shoot a couple of bullets to get the job done. And that is for me Jeckyll is not as powerful as hugo, but get the job done, and there are a lot of tools for it.

## TL;DR

Maintenance is easier with github-pages and Jekyll
