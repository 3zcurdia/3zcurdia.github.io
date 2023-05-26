---
layout: post
title: The State of Rails Monoliths in 2023
description: Unlocking the Power of Monolith Architecture with Full-Stack Engineers and Modern Frameworks
date: "2023-05-25T15:00:00-06:00"
tags:
  - ruby on rails
  - architecture
  - monolith
  - hotwire
---

It's 2023, and I'd like to share my perspective on the Monolith architecture, particularly in the context of Ruby on Rails. Over the years, we've witnessed various trends ranging from SOA to microservices, serverless, and even edge computing. Despite these advancements, the monolith architecture continues to stand strong and shows no signs of fading away. Although it may not be the most popular choice, there is still relevance and value in adopting a monolithic approach in 2023, despite the abundance of articles advocating against it. Allow me to explain my viewpoint and shed light on the benefits it can offer.

# Recessions and full stack engineers

The year is 2023, and with the pandemic behind us, tech companies heavily reliant on lockdown habits have vanished. As interest rates rise, investors now seek higher returns on their investments. The era of massive growth has faded, and companies are prioritizing profitability. To maintain strong financial performance, organizations are actively seeking ways to reduce costs, which has unfortunately led to significant layoffs across the tech industry in recent months. With fewer employees, companies are seeking individuals who can handle multiple responsibilities. Enter the full stack engineers, often referred to as unicorns.

Instead of relying on specialized frontend and backend teams, companies are now seeking individuals capable of handling both domains. This is where the role of full stack engineers truly shines. With a unified team of full stack engineers proficient in both frontend and backend development, companies can leverage the monolith architecture to eliminate the need for complex layers of complexity between APIs and client applications. By working within a monolith, the team's productivity increases significantly, as they can seamlessly collaborate and address both frontend and backend requirements without unnecessary barriers. This streamlined approach fosters efficiency and empowers the team to deliver results effectively.

# Modern web development

A decade ago, we began hearing about modern JavaScript frameworks like Ember or Angular. The advent of Single-Page Applications (SPAs) prompted the division of frontend and backend teams. However, with the emergence of React, the tech world witnessed an explosive growth where everyone aspired to emulate Facebook and utilize their exceptional framework. Undeniably, React is a remarkable tool. However, this trend further widened the gap between frontend and backend development. Nowadays, we often witness specialized teams focused only on React on the frontend, while separate teams handle API development on the backend. Consequently, it appears that building a web application, regardless of a company's size, necessitates the collaboration of both teams comprising skilled and experienced engineers.

# Communication channels does not scale

Another challenge stemming from specialization is communication. Software development extends beyond mere code; effective communication among team members is crucial. However, communication channels pose a combinatorial problem. For instance, in a team of four individuals, the number of communication channels amounts to six. Adding just one more person increases the channels to ten, and each additional team member grows the count exponentially. This issue becomes problematic as the team size grows, leading to an increased amount of time spent in meetings rather than actual product development. This is where cohesive teams excel. By enabling full stack development within a team, the workforce can be reduced, resulting in a decrease in the number of communication channels.

However, a challenge arises as backend developers may not be willing to delve into frontend code. Why is that? The ecosystem surrounding frontend development, particularly JavaScript (JS) and CSS, can be vast. Furthermore, the learning curve associated with component-based frameworks such as React or Vue can be significant. As a result, developers' time allocation may increase due to the additional learning requirements and complexities involved.

# Liveview and Hotwire, frameworks that are changing the game

To address this challenge, we have Liveview and Hotwire frameworks. Liveview empowers developers to create reactive web applications using the Phoenix framework, while Hotwire offers a similar capability for Rails. Both frameworks are built on websockets and enable the development of reactive web applications without relying heavily on JavaScript. This breakthrough is truly revolutionary as it allows a single team to engage in full stack development without being heavily dependent on JavaScript. This is an enormous advantage for the monolith architecture.

The concept of sending HTML over the wire may initially seem disruptive, but it harkens back to the early days of the web before the Javascript hype took hold. However, we now have modern tools that enable us to deliver components using websockets, eliminating the need for extensive JavaScript usage. While this approach has its drawbacks, particularly when it comes to handling multiple connections on the same server, the benefits are substantial. Developers can now deliver reactive components without the necessity of implementing APIs or dealing with complex communication between server and a large JavaScript codebase.

# When you should break out from the monolith?

As a startup, adopting a monolithic architecture should be your initial approach, unless specific business requirements make it challenging to implement. In such cases, consider exploring a Service-Oriented Architecture (SOA) that emphasizes domain-focused principles while sharing similarities with microservices. However, if your team grows to a point where development processes start overlapping and causing conflicts, it may be time to consider a transition.

In terms of frontend considerations, if your website experiences high traffic and encounters issues with rendering time and server connections, it's worth exploring alternatives that shift the heavy workload from the server to the client. However, it's important to note that at this stage, you likely have a specialized team or a team willing to fully dedicate themselves to frontend development.

# Conclusion

In conclusion, I have presented a compelling case for utilizing full-stack engineers and leveraging modern frameworks such as Liveview and Hotwire. These frameworks empower backend engineers to create impressive applications without the heavy reliance on JavaScript, reminiscent of the earlier days of the web. Especially in challenging times like the current economic situation, where companies are seeking cost reduction strategies, the monolith architecture proves to be a valuable approach.

It's important to note that I deliberately excluded discussions on microservices and serverless architectures in this article. I believe that, for the majority of companies, these architectural styles may not be the optimal fit. In a future article, I will delve into the reasons behind this viewpoint, providing a comprehensive analysis to further support my perspective.

By embracing the strengths of full-stack engineers and capitalizing on the capabilities of the monolith architecture, companies can streamline their development processes, enhance productivity, and achieve cost efficiency, all while building robust applications. 