---
layout: post
title: My Rails Way!
description: Crafting Ruby on Rails applications with simplicity, patterns, and seamless integration of third-party services for maintainable and testable code.
date: "2023-05-20T15:00:00-06:00"
tags:
  - ruby
  - rails
  - architecture
  - design patterns
---

As a senior software engineer with extensive expertise in web development using Ruby on Rails, I have gained valuable insights into the framework's capabilities. However, one area where it consistently falls short is in organizing business logic code. While the Rails way emphasizes the importance of having fat models and skinny controllers, this alone is insufficient. As your team expands and the project evolves, maintaining large models can become increasingly challenging. Moreover, Ruby favors smaller objects for efficient garbage collection and memory management. So, how can we address these concerns? In this post, I will unveil my approach to optimizing Rails development for improved code organization and performance. Let's delve into My Rails Way!

When starting a new project, whether it's a complete application or just a new feature, I begin with a straightforward and traditional MVC architecture. This approach allows for mistakes and even duplicated code as part of the learning process. As the project progresses, I introduce new patterns to enhance the codebase while ensuring minimal disruption to existing code. Here are some of the patterns I've employed in my Rails developments.

## Policies

One of my favorite gems for authorization is Pundit. It utilizes POROs (Plain Old Ruby Objects) to simplify the authorization logic with policies, making it easier to implement and test. Adding Pundit to a project has always been one of the earliest decisions I make, and it's a choice I never regret. With the improved syntax in Ruby 3.0, the usage of Pundit becomes even more seamless.

Take a look at the code snippet below, showcasing a sample implementation of a `PostPolicy`:

```ruby
class PostPolicy < ApplicationPolicy
  def index? = true
  def show? = true
  def create? = true
  def update? = owner?
  def destroy? = owner_or_moderator?
end
```

By defining authorization rules within a policy class, Pundit enables fine-grained control over access to specific actions. The `index?`, `show?`, and `create?` methods allow unrestricted access, while `update?` and `destroy?` are conditional based on the owner or a moderator role. Pundit's elegance and flexibility empower developers to create robust authorization systems with ease.

## Decorators

The utilization of decorators can be a topic of debate since, in many cases, a helper is sufficient for presenting objects on the client side. However, when it comes to decorators, they offer the advantage of incorporating rendering logic that can be utilized in various contexts, such as ERB views, API responses, serializers, and more. The remarkable aspect is that you don't need an additional gem for this functionality; you can rely on the standard Ruby library.

Take a look at the code snippet below, demonstrating a simple implementation of a `PostDecorator`:

```ruby
class PostDecorator < SimpleDelegator
  def title_with_author
    "#{title} by #{author}"
  end
end
```

The `PostDecorator` class, leveraging the `SimpleDelegator` class from the standard library, allows you to enhance the presentation of a `Post` object. In this example, the `title_with_author` method concatenates the post's title with the author's name. This enables flexible and reusable rendering logic that can be easily applied across various parts of your application. However, it's important to note that employing decorators solely for a single view might be an excessive approach. Evaluate the necessity and complexity of your requirements before deciding to utilize decorators.

## Query Objects

When dealing with complex queries that involve enabling different sets of filters, ActiveRecord scopes may be sufficient in most cases. However, there are scenarios where utilizing query objects becomes necessary. This pattern provides a centralized entry point for executing queries and offers ease of testing.

To implement this pattern, I create a base class that allows for direct class invocation and includes a pagination method. Here's an example:

```ruby
class ActionQuery
  def self.call(...) = new(...).call

  def paginate(scope) = scope.page(params[:page])
end
```

Inheriting from the base class, any query object can be created by implementing the `call` method. Here's an example of a `SearchPostQuery`:

```ruby
class SearchPostQuery < ApplicationQuery
  def initialize(scope: Post, params: {})
    @scope = scope
    @params = params
  end

  def call
    scope.then(&method(:filter_by_title))
         .then(&method(:filter_by_author))
         .then(&method(:filter_by_category))
         .then(&method(:paginate))
  end

  private

  attr_reader :params

  def filter_by_title(scope)
    return scope unless params[:title].present?

    scope.where(title: params[:title])
  end

  def filter_by_author(scope)
    return scope unless params[:author].present?

    scope.where(author: params[:author])
  end

  def filter_by_category(scope)
    return scope unless params[:category].present?

    scope.where(category: params[:category])
  end
end
```

In query objects, one essential feature I incorporate is the ability to pass the scope functionally using the `then` method. This allows for a chained and visible sequence of filters, as well as passing the scope to subsequent filters.

## Service Objects

The *Query Object* is a specialized form of Service Objects that focuses solely on querying data. However, what happens when you need to perform more than just data queries? This is where I employ service objects to encapsulate business logic and ensure lean controllers.

In such cases, you have the flexibility to choose the approach that suits your needs. Some opt for interactors, while others prefer commands, and so on. I prefer to keep it simple by using POROs.

Here's an example of a `CreatePostService`:

```ruby
class CreatePostService
  def initialize(params: {})
    @params = params
  end

  def call
    Post.transaction do
      create_post
      send_notification
    end
  end

  private

  attr_reader :params

  def create_post
    Post.create!(params)
  end

  def send_notification
    # ...
  end
end
```

Although transactions are not always required, they prove useful when dealing with multiple operations that need to be atomic. By wrapping the creation of a post and the subsequent notification in a transaction, we ensure that either both actions succeed or none at all.

## Third-Party Services

When it comes to utilizing third-party services, I prefer implementing my API wrappers in certain cases. This approach is suitable when you only need to interact with a few specific endpoints of a third-party service, eliminating the need to incorporate an entire gem.

```ruby
module Github
  class Api
    def create_issue(title:, body:)
      conn.post('/repos/:owner/:repo/issues', title: title, body: body)
    end

    private

    def conn
      @conn ||= Faraday.new(url: 'https://api.github.com') do |faraday|
        faraday.request :url_encoded
        faraday.adapter Faraday.default_adapter
      end
    end
  end
end
```

However, when dealing with numerous endpoints or more complex interactions, utilizing a gem becomes preferable. In these cases, I wrap the gem into an adapter, offering the flexibility to switch to a different gem in the future if necessary.

```ruby
class TwilioAdapter
  def initialize(client: Twilio::REST::Client.new)
    @client = client
  end

  def send_sms(to:, body:)
    client.messages.create(
      from: ENV['TWILIO_PHONE_NUMBER'],
      to: to,
      body: body
    )
  end

  private

  attr_reader :client
end
```

In general, for both API wrappers and adapters used with third-party services, I like to organize them within a `services` directory. This keeps the codebase organized and facilitates easier maintenance and future modifications.

## Conclusion

Over the past few years, I have relied on these patterns, emphasizing simplicity and avoiding excessive code engineering. This approach has resulted in a maintainable and testable codebase. Additionally, I prioritize keeping models lightweight, reducing unnecessary complexity.

While I acknowledge that this may not be the definitive best approach, it has proven effective for me. I hope that you find value in this post and discover something useful to apply in your development practices.
