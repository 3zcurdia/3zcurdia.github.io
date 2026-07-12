---
layout: post
title: "Ray Tracing in Elixir"
description: "What Happens When You Run Heavy Math in a 'Slow' Language?"
image: /images/ray-tracing-elixir.png
date: 2026-07-11
tags:
  - computer-graphics
  - algorithms
  - concurrency
  - elixir
  - AI assisted
---

Computer graphics algorithms are fascinating. For a lot of us, Peter Shirley’s *[Ray Tracing in One Weekend](https://raytracing.github.io/books/RayTracingInOneWeekend.html)* was the rite of passage that taught us how light, math, and code intersect. Because ray tracing is brutally compute-heavy, most implementations gravitate toward low-level languages like C, C++, or even Go. Scripting languages? Historically a hard no. Their floating-point performance is notoriously sluggish, and they weren’t exactly built for vector crunching. But in academic experiments have proved Ruby can do it. So why not Elixir?

Sure, it might be "slow" in the traditional sense, but what if we lean into its actual superpower: *fearless parallelism*?

## Setting the Baseline
A while back, I started reading and implementing Shirley’s book. Then, as happens to every developer with half a dozen side projects, life happened. The book "stayed open", the code stayed unwritten, and I moved on to greener pastures.

Recently, I decided to revisit it—but this time, I wasn’t going to start from scratch. I ported Tyler Porter’s Ruby implementation [raytrace-ruby](https://github.com/ty-porter/raytrace-ruby). Why? Because my goal wasn’t just to prove it *could* be done in Elixir. I wanted to answer a different questions:
 - **How slow is elixir/erlang crunching numbers?**
 - **How much parallelizaion helps compute-heavy algorithms?**

To establish a baseline, I ran the original Ruby version on my Mac Mini Pro (8+4 cores). It finished in **1h 47m**. (A massive jump when the Tyler reported 6 years ago it took 6-hour runtime on Ruby 2.6 and hardware has come a long way, thank goodness.)

## Elixir is Faster Than Ruby?
Now that I have a baseline, let’s run my Elixir port. To my surprise, it finished in **42 minutes**. That’s roughly **2.5× faster** on a single core. But Why?

It’s not magic, it’s architecture.

| Factor | Ruby | Elixir/Erlang | Impact |
|---|---|---|---|
| Object layout | `RClass` with ivar table, dynamic dispatch | Compact tuple/struct, pattern matching | ~2-3× less memory per allocation |
| GC | Stop-the-world mark-sweep | Per-process generational, concurrent | No pause spikes during long renders |
| Math calls | `Math.sqrt` (C), but through Ruby's method dispatch | `:math.sqrt` (Erlang NIF, direct) | Slightly faster FP ops |

That **2.5× single-core advantage** comes primarily from **BEAM’s per-process memory management** and **struct memory density**. Each `Vector3D` in Ruby carries a full Ruby object header and hash-table lookups, whereas an Elixir `%Vector{}` struct is a compact tagged tuple under the hood. With roughly **225 billion allocations** over a single render, that memory efficiency compounds into a real-world speed advantage.

But single-core speed is just the warm-up. Elixir (and the BEAM VM) were built for concurrency. So I made the simplest possible change: swap the nested `for` loop for `Task.async_stream`.

```elixir
      for j <- (height - 1)..0//-1, i <- 0..(width - 1), into: [] do
        IO.write(:stderr, "\rScanlines remaining: #{j + 1} ")
        render_pixel(camera, world, i, j, width, height, spp, max_depth)
      end
```

{% raw %}
```elixir
      (height - 1)..0//-1
      |> Task.async_stream(
        &render_line(camera, world, width, height, spp, max_depth, &1),
        ordered: true,
        timeout: :infinity
      )
      |> Enum.with_index()
      |> Enum.flat_map(fn {{:ok, line}, idx} ->
        IO.write(:stderr, "\rScanlines remaining: #{height - idx - 1} ")
        line
      end)
```
{% endraw %}

That’s it. By handing each render line to the scheduler and processing them in parallel across a 12-core Apple Silicon machine, runtime dropped from **42 min to 3 min**. **14× faster**, just by embracing functional concurrency.

## Optimization 2: Bounding Volume Hierarchy (BVH)
On the second book, we hit a classic computer graphics concept: **[Bounding Volume Hierarchy (BVH)](https://raytracing.github.io/books/RayTracingTheNextWeek.html#boundingvolumehierarchies)**.

In a naive ray tracer, every ray checks every primitive in the scene. That’s **O(N) per ray**. BVH organizes geometry into a spatial tree. For each ray, the algorithm only traverses a node if the ray actually intersects its bounding box. This drops complexity from **O(N) to O(log N) per ray**.

Implementing BVH was a game-changer. Render times plummeted to **9 seconds**, and CPU usage soared past **1000%** (basically, every core was screaming). If I’d added BVH to the Ruby version, it would’ve slashed the runtime too but here, Elixir’s scheduler turned algorithmic gains into wall clock reality.

## Optimization 3: Tiling the Scheduler
Rendering line-by-line sounds efficient, but on large images it starves the BEAM scheduler and creates load-balancing bottlenecks. The fix? **Tiling**.

I split the image into fixed **64×64 tiles** and distributed them across workers. This reduced scheduler contention, brought peak usage down to a more stable **892%**, and pushed the runtime to **~10 seconds**. (Yes, technically slower than 9 seconds, but far more predictable and closer to real-world production behavior.)

## What’s Next & The Big Picture
So, what’s next? I’m currently experimenting with `Nx` (Elixir’s numerical library). My initial attempts actually ran slower than line-by-line parallelization, likely due to overhead and compilation quirks, but I’m still digging deeper.

The real frontier, though, is **distribution**. One of Elixir’s killer features is transparent node-to-node scaling. Distributing this ray tracer across a cluster shouldn’t require distributed systems jitters—just a few config changes. But to make that worthwhile, I’ll need to continue into Shirley’s next books (whew, there are three of them).

In an era where clock speeds have plateaued but core counts keep climbing, parallelism isn’t just an optimization it should be the standard. Languages like Erlang/Elixir were born for this. We aren’t waiting for faster CPUs or magically faster programming languages; we’re leveraging the parallel capacity already sitting on our desks. And algorithmic improvements? They’re the real heavyweight champions. BVH alone proved that better math often beats raw hardware.

### A Side Note
This project finally crossed the finish line thanks to open-weight AI models like **GLM-5.2**, **MiniMax-M3**, and **Kimi K2.7**. When the best open models start acting like pair programmers, even abandoned repos can find their second wind. Thanks, AI. I owe you a beer.

[source code](https://github.com/3zcurdia/exray)
