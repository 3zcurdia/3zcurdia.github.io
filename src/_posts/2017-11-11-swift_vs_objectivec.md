---
layout: post
title: "Swift Vs Objective-C"
description: "languages perks and differences"
date: "2017-11-11T20:55:32-06:00"
tags:
  - swift
  - objective-c
  - benchmark
---

Since 2014 Swift programming language has gotten the fascination of developers and strangers, but what about the old and reliable Objective-C, that for years has been the default language in iOS and OSX applications.  Is Objective-C dead? Do the new generations should only know Swift? Is Swift the tool for everything? In this article, I will try to answer those questions, by comparing them in different categories.

> In this article I am not considering backend development with Swift

## Learning curve
Besides the early adoption of many developers in the apple scene, swift it is more complicated than their counterpart. Indeed the swift syntax is more comfortable to read to the naked eye, but some concepts like the "optional type" in Objective-C are not required. The learning curve of Objective-C is faster because the syntax inherits from C with the addition of an object-oriented programming and a lot of square brackets. Once a developer gets used to the many brackets, it will be good to go and develop applications.

## Convenience
However Swift is more convenient to work with because it facilitates the developer with a friendly syntax and a ton of resources provided by a thriving community. Although most of the common problems have been resolved in both languages, objective-c libraries tend to be more mature and stable, and swift libraries to be more active and in constant improvement.

## Performance
At this moment they are rare cases where Swift performs better than Objective-C, but since the launch in 2014 of Swift the performance has increased dramatically, and future versions will continue improving it. Regarding the memory footprint, Swift could be more expensive, but the memory in Apple devices it raises in each iteration, and this will never become a blocker.

Also, most of the applications work as a frontend for a solid business logic in the backend. Rendering UI components, making API requests, parsing responses, displaying text or images does not require heavy processing and a difference from milliseconds to microseconds it won't improve the user experience because from the human perception it is same.

## Scalability
This topic does not depend on the language itself. It resides in the design patterns and conventions adopted by the team. If an inexperienced developer builds a product, it would contain a lot of technical debt and eventually, it'll be hard to scale, and the MVC pattern will not save him from writing spaghetti code.

However, the Swift community it welcomes not only newer developers but also experienced and they come with ideas that in Objective-C will be hard to implement. By example, swift attributes observers, along with protocols and generics allows reactive programming through a [native library](https://github.com/ReactiveKit/Bond) making the MVVM pattern easier to implement.

## Conclusion

It is undeniable that Swift is a thriving language with an active community, but that does not mean that Objective-C is dead. All newcomers must at least understand Objective-C which is not complicated in comparison to C++. We must remember that Swift foundation is Objective-C, and most legacy projects still have it, so we will have to be able to work with it. A developer who know both languages and understand the potential of each one of them, we will be a valuable asset to any engineering team.
