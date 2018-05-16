---
layout: post
title: "Benchmark tools for Rubyist"
description: "4 useful tools to benchmark and profile your web application."
date: 2015-12-12T13:37:48-06:00
background: /assets/images/post-bg.jpg
tags:
  - coding
  - tip
  - ruby
  - web
---

> When in doubt test it!

Sometimes in the development process you might find yourself with the need to know if a component is performing better or worse, there are couple ways to get that information, one is through run benchmarks and you could do it from server side handling it as another test within your suite, or you can test the response times on your app with some external tools to get a better profile.

## Server Side benchmark with ruby

Ruby bit itself has a benchmark lib which allows you to get the elapsed times evaluated within a code block

{% highlight ruby linenos %}
    require "benchmark"
    n = 10_000_000
    Benchmark.bmbm do |x|
      x.report %(string = '') do
        n.times do
          foo = 'bar'
          foo = ''
        end
      end
      x.report 'string.clear' do
        n.times do
          foo = 'bar'
          foo.clear
        end
      end
    end
{% endhighlight %}

Getting as result but sometimes you need to get a better comparison.

    Rehearsal ------------------------------------------------
    string = ''    1.740000   0.010000   1.750000 (  1.755114)
    string.clear   1.550000   0.000000   1.550000 (  1.565770)
    --------------------------------------- total: 3.300000sec        

                   user     system      total        real
    string = ''    1.740000   0.010000   1.750000 (  1.750512)
    string.clear   1.550000   0.010000   1.560000 (  1.566237)

To get a more clear result you can use `benchmark-ips` which it will benchmark by iterations per second.

{% highlight ruby linenos %}
    require 'benchmark/ips'    

    n = 10_000_000
    Benchmark.ips do |x|
      x.report(%(string = '')) do
        array = []
        n.times do
          foo = 'bar'
          foo = ''
        end
      end
      x.report('string.clear') do
        n.times do
          foo = 'bar'
          foo.clear
        end
      end
      x.compare! # Print the comparison
    end
{% endhighlight %}


Getting a better presentation results in terms of comparsion

    Calculating -------------------------------------
             string = ''     1.000  i/100ms
            string.clear     1.000  i/100ms
    -------------------------------------------------
             string = ''      0.548  (± 0.0%) i/s -      3.000  in   5.478312s
            string.clear      0.608  (± 0.0%) i/s -      4.000  in   6.582271s  

    Comparison:
            string.clear:        0.6 i/s
             string = '':        0.5 i/s - 1.11x slower


## Profile response times

One very useful tool could be `siege` with will request with concurrency a url and get the average from the response times

    siege -c 10 -r 100 https://example.com

Getting as result

    Transactions:		         1000 hits
    Availability:		       95.00 %
    Elapsed time:		     1916.76 secs
    Data transferred:	        5.28 MB
    Response time:		       33.94 secs
    Transaction rate:	        0.25 trans/sec
    Throughput:		        0.00 MB/sec
    Concurrency:		        8.50
    Successful transactions:         480
    Failed transactions:	         520
    Longest transaction:	       33.57
    Shortest transaction:	        0.59

Another similar tool is `wrk` that allows you to get simultaneous connections using threads

    wrk -c 1000 https://example.com

Getting as result

    Running 10s test @ https://example.com
      2 threads and 1000 connections
      Thread Stats   Avg      Stdev     Max   +/- Stdev
        Latency     1.42s   529.90ms   1.90s    60.00%
        Req/Sec     6.61      6.47    29.00     78.95%
      50 requests in 10.05s, 2.62MB read
      Socket errors: connect 0, read 0, write 0, timeout 45
    Requests/sec:      4.97
    Transfer/sec:    266.75KB


## TL;DR

There is no excuse to benchmark your code either you do it on the backend or through profiling tools.
