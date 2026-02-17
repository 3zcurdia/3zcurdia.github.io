---
layout: post
title: "Lessons Learned from a computer graphics background"
date: "2016-04-22T09:46:47-05:00"
tags:
  - programming-languages
  - computer graphics
  - learning
  - coding
---

The dream from almost all computer nerd is to make his own video game, unfortunately this goal
is harder than we though. It turns that is not only required a computer science knowledge, but
an additional amount of skills, from complex math to 3d modeling and game design.

When I finished college, I realized that if I wanted to build a video game I will need to work
with a big team to build a good one, or at least have some artistic gifts(which I don't have).
All those things that I learned about computer graphics are useless? now that I am working as a web
developer? As a mater of fact, YES. But not entirely there some lessons that I learned and
applied on my early years without even knowing. Here is what I learned.

## Load once but make it right

One of the most common exercises on 3D graphics is to build your own 3d file loader.
This task must sound pretty easy: open a file, parse it and put into an structure that
can you can use later right? Well is not that easy, but that is rough idea of the steps needed.
In general loading a complex mesh it will take a really long time and what it really matters is not
how fast but how well is loaded. Having missing triangles or normals pointing to the wrong
direction it will be easy noticed, rather than a slow load of more than 10 seconds, even if
the mesh has more than one million vertex(like the Stanford buddha) the small error in the data
is noticed.

On web development you do not load one million of records, but you initialize several things
like environment variables, load configuration files, setup third party services, run migrations,
etc. Yes some of those things could be slower than the rest of the application, it wont matter the amount
of time needed to do those things as long you are doing it right.

## Parsing files, will help you to parse everything

On the exercise for the 3d file loader, you will have to learn the structure and the patterns
from a file, and line by line translate text into vectors, vertex, triangles, groups and meshes, among
other things like colors or materials. Having this skill on the web community seems useless
until you find yourself parsing request parameters, headers, or even files like csv. I consider
a good exercise for a developer to try to parse a file without any library, this knowledge
will sharp your skills for regular expressions, or any other method to parse a string.

## Math is beautiful

One of the hardest class on high school for me was math, but I knew that was only path to become
an engineer. On my junior year in college all my classes were about math and physics, the struggle
was real, but at the end I realized that I really like math, is simple its always true and of course
theres is just one right answer. Over the years the use of algebra and calculus became less frequent, and
the use of logic turned to be my daly bread. And on graphics all the things are vectors math, and for images
the FFT(Fast Fourier Transform) as the base for many image process. Math is everywhere, from
the logic behind the browser where you are reading this article, to the algorithm to uncompress the
images to be rendered.

As a web developer I don't care about the transformations required to detect 3d collisions, or the math
required to filter an image on Instagram, but I really care about some binary and logic operations. The less
operations I do the simpler my code will look. Taking care of your logic skills will turn your code better and
other developers will appreciate it.

## Make it faster is harder

The programming language who rules computers graphics is ``C++``, although there some really popular frameworks
written on an interpreted or script language like ``javascript`` no one beats ``C++``. But why? is the language faster? YES
and maybe ``Go`` could fight this battle. Does ``C++`` has a vast ecosystem for graphic libraries? YES
and maybe ``Java`` has a vast libraries for graphics too but there are not fast as ``C++``, because it is compiled. The language is not an easy language, no matter how good you are you will face errors harder to debug or even worst execution errors
that no one expect to happen. On web development we use to have ``PHP`` (well we still have it) and that was enough, but now
we have compiled languages like ``Go`` or ``Rust`` that can deliver pages in nano seconds, but for those languages you will
need to write more code to do the same things that a few lines of ``Ruby`` or ``Python`` will do.

Being fast is expensive in terms of development effort, but sometimes is not worthy to load an entire page in nanoseconds,
the business logic should not depend on the fast page delivery, but on the quality of the service you provide,
and the ability to change fast and evolve with a changing market. Where you need to be more efficient is on your business
not in the nanosecond window.

## Don't build everything you need

On my early years as a junior developer for a ``C++`` team, we found ourselves developing tools for an event where it was required to have
a chat to coordinate different locations and be able to transfer files to a centralized server. At the time the lead developer
a guy with a masters degree and years of experience on computer graphics, managed to build the required chat on ``C++``. The
chat worked fine, but for me it was really painful to install the software in more than the 30 computers and the following
updates, besides we had to ask to the IT departments of the locations to open a port for the application. In my opinion a web chat
builded with web sockets and ability to upload the files with a simple form under a secure protocol server was the right fit.
The software we had worked, but cost of building everything from zero was too expensive.

I know you are a GREAT developer, and your can build anything, but sometimes you have to trust the code and libraries from
other people. You don't need to prove yourself or your boss that you are great by building an entire software from scratch,
most of the times all that you need is put to work together the libraries you need. Remember you are builder of business,
not a builder of algorithms.

<blockquote class="blockquote-reverse">
  You are builder of business,not a builder of algorithms.
</blockquote>

## The one man band: there is not such thing

Back on college I meet an awesome developer who build an entire mod for a game(with zombies) everyone who watched the
demo wanted to play it, unfortunately that project was never released to the public, but why? Why an awesome product
never saw the light? Well the answer is very simple this developer is a "One man band", he can do it everything, or I must
say he want to do everything, from the conceptual art, to the 3D modeling to the marketing and the web development. Taking
the entire burden for any project with a very high expectations is not easy, you need to really in some kind of parter.

There is no successful startup with a single founder, you need someone who has the same passion for the project as you do.
The best part is you can complement each other, there is no need to have the same skills, imagine it like a marriage.
You want a parter to be compatible, but you need that his qualities are different than yours.
It is a long and painful road, you better to be in a good company.

<blockquote class="blockquote-reverse">
  It is a long and painful road, you better to be in a good company.
</blockquote>

## Conclusion

Having computer graphics background will not revolutionize the way the web development is made. But for
sure there are some aspects that I learned on my early years that help me to become an informed developer.
And because I know how painful is to build a library on ``C++`` and how fun is to do it with ``Ruby``,
I will love to have the more speed in ``Ruby``, but that wont make any difference in my business,
and the cost or rebuilding an entire platform with a compiled language like ``Go`` or ``Rust``,
wont give me thousands of customers. What it really matters is how fast your business react to a
constant evolving market, and how you keep it relevant.
