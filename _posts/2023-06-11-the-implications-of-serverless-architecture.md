---
layout: post
title: "The Implications of Serverless Architecture: Beyond the Hype"
description: Navigating the realities and strategies of Serverless Architecture
date: "2023-06-11T13:00:00-06:00"
tags:
  - architecture
  - microservices
  - serverless
  - design patterns
---

In recent years, cloud providers have been promoting serverless architecture as a preferable option to microservices. Consequently, many developers have readily embraced it without fully considering the architectural consequences. This article aims to highlight the less-discussed implications of serverless, excluding well-known concerns such as cold start, cost unpredictability, and limited environmental control.

## The idea

The essence of serverless architecture lies in the execution of on-demand, stateless functions managed by the cloud provider. These functions run on scalable servers, adjusting to demand as required. By breaking down your system into multiple functions, you can achieve easier maintenance and cost efficiency. When the domain is well-defined, serverless architecture serves as a viable alternative to microservices.

## Domains harder to define

Event-driven design plays a central role in a serverless architecture. However, when developers are unfamiliar with this paradigm, it can lead to a chaotic situation. From its inception, serverless architecture abstracts away the context of a domain. In the early stages of a project, when many unknowns exist, multiple changes are expected. As these changes occur, patterns emerge, and the domains gradually become better defined over time. When starting a project with a serverless approach without a clear understanding of the domain, it can result in a chaotic architecture.

In a monolithic architecture, grouping related logic can be achieved by organizing code into different modules. Similarly, in a microservice architecture, code can be separated into different services. However, in serverless architecture, the code is already divided into functions, making it challenging to group them. The only option is to create a new function that calls other functions, but this introduces circular dependencies and adds a function that may not align with the domain. This approach is not considered ideal within the serverless paradigm.

## Circular dependencies

Circular dependencies occur when compute modules call each other, creating a dependency loop that can complicate code maintenance and lead to undesired consequences. While not exclusive to serverless architecture, detecting circular dependencies can be challenging without strong typing and static analysis tools. They are many tools to detect this problem in statically typed programming languages, however, the challenge with dynamic languages resides in the fact that the type is not known until runtime.

The Elixir community has made notable progress in tackling circular dependency problems within Elixir projects through tools like [Archeometer](https://www.hex.pm/packages/archeometer). Elixir, being a compiled language for the BEAM virtual machine, benefits from the ability to analyze code during the compilation process. However, I am not currently aware of any specific tool for other dynamic-type languages. There might be potential solutions available for TypeScript, but further exploration is required to identify such tools.

## We Love Typing

Developers often strive for DRY (Don't Repeat Yourself) code to maintain a clean architecture and promote shared knowledge. However, when developing serverless functions, duplicated code becomes a common challenge. Serverless functions typically cannot directly share code, leading to code duplication. To address this, a common approach is to develop a library that encapsulates shared functionality between functions. This library can then be utilized across multiple functions, mitigating the issue of duplicated code in serverless architectures.

Copying and pasting code to address the issue of shared functionality in serverless functions is not considered a good practice. It leads to a proliferation of duplicated code, which can become problematic to maintain. When changes are required, they need to be made in multiple places, increasing the likelihood of inconsistencies and outdated functions. It's important to avoid this approach and instead explore alternative solutions, such as developing a shared library or modularizing the codebase, to promote code reusability and maintainability.

## Shared knowledge

One of the key principles of agile development is maintaining shared knowledge within the development team, allowing any team member to work on any part of the system. However, this can become challenging when managing multiple microservices. Due to the workload and fast pace, there is a tendency to assign a single engineer to a specific microservice, which results in knowledge silos. If that engineer is unavailable or leaves the company, critical knowledge can be lost.

As a general rule, it is recommended to have at least two engineers responsible for each microservice. If this is not feasible, it may indicate that the microservice approach is not suitable for the given situation.

In the serverless world, a similar challenge arises. Instead of managing microservices, individual functions need to be maintained. This can be more challenging because the number of functions to manage can be significantly higher. Even if all the functions are stored in a single repository, the code is not shared, leading to knowledge silos and potential knowledge loss within the team.

To mitigate these issues, it is essential to prioritize knowledge-sharing practices, such as pair programming, code reviews, and documentation, to ensure that the team collectively possesses the knowledge necessary to maintain and enhance the serverless functions.

## Testing nightmare

Splitting into microservices has posed challenges for testing, but the serverless world takes it to another level. While it may seem feasible to create unit tests for each function to achieve 100% test coverage, human error or the potential for overlooking edge cases still exists. Integration tests are typically used to mitigate this, but in the serverless context, new challenges arise.

Running integration tests in the serverless world requires a test suite that simulates the behavior of all functions in a production-like environment. One approach is to use containers to replicate the production environment, which initially appears promising. However, as the number of functions increases, running these integration tests can become resource-intensive and significantly impact the CI/CD pipeline. It's crucial to be cautious as this approach can lead to an abundance of flaky tests that are unreliable and time-consuming to maintain.

Finding a balance between comprehensive test coverage and resource efficiency is essential in serverless architectures. Employing a combination of unit tests, integration tests, and carefully designed test strategies can help ensure reliable and efficient testing practices in the serverless environment.

## Conclusion
In conclusion, serverless architecture is a valuable concept, but it should not be considered a complete replacement for microservices. It works well when the domain is well defined, and the development team is familiar with event-driven design. However, it is essential to be mindful of potential challenges and problems that can arise.

Carelessness in serverless development can lead to difficulties and complications. Therefore, it is advisable to use serverless architecture when the scope of the project is limited and not expected to grow exponentially in the future. If there is uncertainty about the future scalability or complexity, it may be more suitable to consider microservices or even a monolithic architecture.

Ultimately, the choice of architecture should align with the specific requirements, scalability needs, and expertise of the development team. It is crucial to carefully evaluate the trade-offs and select the most appropriate approach to ensure the long-term success and maintainability of the system.