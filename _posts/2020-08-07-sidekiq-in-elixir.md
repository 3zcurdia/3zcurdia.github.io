---
layout: post
title: Do We Need Background Jobs in Elixir?
description: Perhaps not, if we knew the OTP well
date: "2020-08-07T18:00:00-06:00"
tags:
  - elixir
  - ruby
  - concurrency
---

In Ruby, we've become accustomed to using background jobs through tools like Sidekiq or Resque. In this post, we'll explore the benefits of One-to-One (OTP) concurrency.

## Hold your horses! OTP to the rescue

When faced with concurrent background processing, our instinct as developers tells us to "just search 'sidekiq in Elixir'." This would lead us to results that include some implementation of queuing systems. But if we knew a little about what the OTP (One-to-One Process) offers, we wouldn't look for third-party solutions, but rather implement a solution better suited to our needs.

One of Elixir's most prominent features, which Ruby lacks, is concurrency. And although the community has generated various parallel processing solutions, this is more applicable to languages ​​where concurrency doesn't exist. In the case of background jobs, it's very common to have a separate process that runs in parallel and communicates through messages that travel via Redis, RabbitMQ, or even the database itself. But is all this necessary in Elixir? How can we avoid this communication with external services?

## Procesos y Tareas

According to the Elixir documentation:

> Processes are isolated from each other, run concurrently, and communicate via message passing. Processes are not only the basis for concurrency in Elixir, but they also provide the means for building distributed and fault-tolerant programs.

This is the foundation of concurrency in Elixir. Just as in Ruby everything is an object, in Elixir everything is a process, or rather, we can put everything into smaller processes, which opens the door to the world of concurrency.

Let's suppose we want to have a process that we don't mind failing, such as metrics. In Ruby, we would try to make it take the shortest possible time, or we would send it to a background job. How would we do it in Elixir? Simply by sending it to a different process:

```elixir
spawn fn() -> Metrics.Purchase.complete end
```

Is that all? Yes, that's really all we need in this case, since the only thing that matters to us is that it doesn't block the main process.
Now, we could also do the same thing using tasks:

```elixir
Task.start fn() -> Metrics.Purchase.complete end
```

So what's the difference? Tasks are built on processes and provide better error reporting, since they return a tuple of values ​​`{:ok, pid}`. If desired, we can implement a mechanism that gives us greater control over the result.

## GenServers

However, neither processes nor tasks persist their state once they finish. What if we wanted to store something at runtime? Would we write it to disk? Save it to the database? While this might be the most convenient approach in some cases, we have another tool at our disposal: GenServers, or generic servers. These allow us to persist state using a basic structure that we can adapt to our needs.

```elixir
defmodule Example.Registry do
  use GenServer

  # Client
  def start_link(_opts) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def add(key) do
    GenServer.cast(__MODULE__, {:add, key})
  end

  def find(key) do
    GenServer.call(__MODULE__, {:find, key})
  end

  # Server
  @impl true
  def init(_opts) do
    {:ok, %{}}
  end

  @impl true
  def handle_cast({:add, key}, state) do
    updated_state = Map.put(state, key, LongRunningProcess.run(key))
    {:noreply, updated_state}
  end

  @impl true
  def handle_call({:find, key}, _from, state) do
    value = Map.get(state, key)
    if is_nil(value) do
        {:reply, {:error, "Not found"}, state}
    else
        {:reply, {:ok, value}, state}
    end
  end
end
```

In this example, we'll notice that there's much more code than we'd typically use in a Ruby worker. If we analyze it in detail, we'll see that our server has a small client-server architecture. Therefore, we would use our GenServer in the following way.

```
iex> Example.Registry.add("something")
iex> Example.Registry.find("something")
{:ok, 21wqeds24354trgfdq2365ytgfde23465}
```

Now, on the server side, we have an initialization of the `init` state and handlers. The `handle_cast` function allows us to make asynchronous calls that expect a tuple `{:noreply, state}` as the return value, while `handle_call` expects a synchronous response with the tuple `{:reply, value, state}`.

The equivalent in Ruby would be having a worker in the background job, state stored on an external medium, and a client that grants us access to it. Here, however, with the use of a simple `GenServer`, we have an asynchronous client-server application in just a few lines of code.

## So When Do I Use Background Jobs?

In most cases, we don't need a background job in Elixir; we could practically build everything we need using the OTP (One-Time Processor). However, we might want greater control, such as disk persistence, defining a worker pool, retries, and other features. Several solutions exist for this, the most popular of which are:
- [Oban](https://github.com/sorentwo/oban) a robust PostgreSQL-based backend queue processing system. It has a UI in its pro version.
- [Exq](https://github.com/akira/exq) a Redis-based processing library compatible with Resque and Sidekiq. It has an open-source UI, exq_ui.
- [verk](https://github.com/edgurgel/verk) like Exq, it is compatible with Resque and Sidekiq jobs. Other options exist, but these projects are not as popular and are partially abandoned. If you venture to use them, keep in mind that this can result in technical debt.

## Conclusion

Thanks to the OTP in Elixir, we have a wide range of tools that facilitate concurrent processing and could eliminate the need for third-party dependencies. In this post, I only mentioned a few of them, but it would be worthwhile to explore them further on your own.

- [Task](https://hexdocs.pm/elixir/Task.html)
- [GenServer](http://elixir-lang.org/getting-started/mix-otp/genserver.html)
- [GenStage](https://hexdocs.pm/gen_stage/GenStage.html)
- [Supervisor](http://elixir-lang.org/getting-started/mix-otp/supervisor-and-application.html)
- [OTP](http://erlang.org/doc/)

[source](https://sipsandbits.com/2020/08/07/do-we-need-background-jobs-in-elixir/)
