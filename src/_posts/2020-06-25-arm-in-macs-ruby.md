---
layout: post
title: ARM on the Mac, from a developer's perspective
description: Will ARM-based technologies affect software development?
date: "2020-06-25T20:55:32-06:00"
tags:
  - apple
  - arm
---

A few days ago, Apple revealed its plans to integrate ARM-based processors into its desktop computers, leaving Intel's x86 processors behind. But what does this mean for us developers?

Today, in the vast majority of projects, we don't worry about the architecture our software will run on. This burden falls on the compilers that currently allow us to distribute our software for different platforms. However, this doesn't mean we'll ignore the issue in the medium and long term.

## ARM is everywhere

First, let's address the elephant in the room. ARM architecture is everywhere, from our mobile devices to our vehicles, and even in our consoles and graphics cards. This is because ARM's business model isn't manufacturing, but rather designing and licensing its processors. Therefore, companies like AMD, Qualcomm, Nvidia, Nintendo, Apple, and others can have their own custom chips at a low cost. Furthermore, with the Internet of Things, gadget manufacturers have sufficient processing power with low energy consumption. This is why this market has exploded in the last decade, and there's probably an ARM processor near you.

## High-Level Languages

The vast majority of us work with very high-level languages, and in our day-to-day work, we don't focus on low-level issues, such as compatibility with different processors. As I mentioned before, we leave this workload to compilers, which allow us to have binaries for any architecture. In the case of Java, with the introduction of Android, its virtual machine had to be able to run on ARM processors, and all the development community did was adapt the ecosystem to limited resources and improve performance. In the case of languages ​​that depend on an interpreter, such as Ruby or Python, they work perfectly well on embedded systems or the Raspberry Pi. Even in Japan, Ruby's use is more focused on these types of systems. So this change shouldn't worry most of us.

## Third-Party Dependencies

However, not all the code we produce comes from our own hands. Often, we depend on the work of others, who in turn depend on others, and so on. This practice of free software has made our lives easier, and thanks to it, we've avoided reinventing the wheel with each project. However, we might have dependencies tied to a certain architecture, and this could be happening without us even realizing it.

To avoid this, we need to test our code on different platforms. The most accessible option would be to test our production project on a Raspberry Pi or BeagleBone. Perhaps our software requires much more processing power, but at least we'll know if our dependencies work in the near future, or if we need to make adjustments.

## But it works in my local environment

For those familiar with the phrase "Brace yourself," because if you're a backend developer, you might find yourself saying it even more often than you're used to. The difference in the instruction set between our development and production environments will be considerable. However, if we make the transition well, the problems in development environments might be annoying but manageable.

Fortunately, mobile development would benefit since applications would be developed in environments very close to mobile devices. Both the Android emulator and the iOS simulator would have a significant advantage.

## ARM on the server?

Currently, our backend projects run in the cloud, whether it's Amazon, Google, or another provider. And while the data center market is entirely dominated by Intel, this doesn't mean that these cloud service companies aren't looking for more cost-effective alternatives. In economic terms, reducing energy and cooling costs can have a significant impact on these companies' profits, since powering and maintaining these systems at optimal operating temperatures is extremely expensive. Therefore, in the near future, we will likely see more eco-friendly options in the backend, without sacrificing performance.

In conclusion, ARM is a technology with over 30 years in the market, which has become embedded in various industries in the last decade. Thanks to its thermal efficiency and low energy consumption, it is very attractive for a future where efficiency takes precedence over raw performance. This technological shift shouldn't surprise us, because whether we like it or not, Apple leads the market trends.

[Source](https://sipsandbits.com/2020/06/26/arm-based-macs-from-the-developers-perspective/)
