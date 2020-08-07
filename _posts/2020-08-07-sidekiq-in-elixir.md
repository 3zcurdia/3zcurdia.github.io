---
layout: post
title: ¿Necesitamos Background Jobs en Elixir?
description: Tal vez no, si conociéramos bien la OTP
date: "2020-08-07T18:00:00-06:00"
tags:
  - elixir
  - ruby
  - background jobs
---

En Ruby nos hemos acostumbrado al uso de background jobs por medio de herramientas como Sidekiq, o Resque. En este post veremos los beneficios de la OTP al utilizar la concurrencia que esta ofrece.

## Hold your horses! OTP to the rescue

Al enfrentarnos con procesamiento concurrente en el background nuestro instinto como desarrolladores nos dice "solo busca 'sidekiq en Elixir'". Lo cual nos llevaría a resultados entre los cuales encontraríamos alguna implementación de sistemas de encolado. Pero si conociéramos un poco de lo que nos ofrece la OTP no buscaríamos soluciones de terceros, sino implementariamos una solucion más de acuerdo a nuestra necesidad.

Una de las caracterisicas más destacadas de elixir y de la cual Ruby carece, es la concurrencia. Y aunque la comunidad ha generado diversas soluciones con  processamiento paralelo, este solo aplica más a lenguajes en donde la concurrencia no existe. En el caso de backgroud jobs es muy común tener un proceso separado que corre en paralelo y se comunica  por medio de mensajes que viajan a través de Redis, RabitMQ o incluso la misma base de datos. Pero, ¿es necesario todo esto en elixir? ¿Como evitaríamos esa comunicación a servicios externos?

## Procesos y Tareas

De acuerdo a la documentacion de Elixir
> Processes are isolated from each other, run concurrent to one another and communicate via message passing. Processes are not only the basis for concurrency in Elixir, but they also provide the means for building distributed and fault-tolerant programs.

Lo anterior es la base de la concurrencia en Elixir. Así com en Ruby todo es un objeto, en Elixir todo es un proceso o, mejor dicho, podemos poner todo en pequeños procesos, lo cual nos abre las puertas al mundo de la concurrencia.

Supongamos que queremos tener un proceso que no nos importa si llega fallar, tal como es el caso de las métricas. En el caso de Ruby trataríamos de que tome el menor tiempo posible, o bien lo mandamos a un background job. ¿Cómo lo haríamos en Elixir? Simplemente enviándolo a un proceso diferente:

```elixir
spawn fn() -> Metrics.Purchase.complete end
```

¿Es todo? Sí, realmente es todo lo que necesitamos en este caso, ya que lo único que nos importa es que no bloquee el proceso principal.
Ahora, tambien podríamos hacer lo mismo utilizando tareas:

```elixir
Task.start fn() -> Metrics.Purchase.complete end
```

¿Entonces cual es la diferencia? Las tareas estan construidas sobre procesos y proveen un mejor manejo de reporte de errores, ya que regresan una tupla de valores `{:ok, pid}`. Si lo deseamos, podemos implementar un mecanismo que nos brinde un mayor control sobre el resultado.

## GenServers

Sin embargo, tanto los procesos como las tareas no persisten el estado una vez que finalizan. ¿Qué pasaría si quisiéramos almacenar algo en tiempo de ejecución? ¿Lo escribimos en disco? ¿Lo guardamos en la base de datos? Es cierto que en algunos casos será lo más conveniente, pero tenemos otra herramienta a nuestra disposicion. Los GenServers o servidores genéricos, los cuales nos permiten persistir el estado con una estructura base que podemos adaptar a nuestras necesidades.

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

En este ejemplo podremos notar que hay mucho más código del que normalmente usaríamos en un worker de Ruby. Si lo analizamos a detalle notaremos que nuestro server cuenta con una pequeña arquitectura cliente-servidor. Por lo que utilizaríamos nuestro GenServer de la siguiente forma.

```
iex> Example.Registry.add("something")
iex> Example.Registry.find("something")
{:ok, 21wqeds24354trgfdq2365ytgfde23465}
```

Ahora, del lado del server tenemos una inicialización del estado init y manejadores. La función handle_cast nos permite hacer llamadas asíncronas que esperan una tupla `{:noreply, state}` como valor de retorno, mientras que handle_call espera una respuesta sincronía con la tupla `{:reply, value, state}`.
El equivalente en Ruby sería tener un worker en el background job, un estado almacenado en un medio externo y un cliente que nos de acceso a él. Mientras que aquí, con el uso de un simple GenServer, tenemos una aplicación cliente-servidor asíncrona en unas cuantas líneas de código.

## ¿Entonces cuándo utilizo Background Jobs?

En la mayoría de los casos no requerimos de un background job en Elixir, practicamente podríamos construir todo lo que necesitamos utilizando la OTP. Pero es posible que queramos tener un mayor control, tal como persitencia en disco, definir un pool de workers, reintentos, entre otras cosas. Para ello existen varias soluciones, de las cuales las más populares son:
- [Oban](https://github.com/sorentwo/oban) un robusto sistema de queue backend process basado en postgresql. Cuenta con una UI en su version pro
- [Exq](https://github.com/akira/exq) una biblioteca de procesamiento compatible con Resque y Sidekiq basada en Redis. Cuenta con una UI open source exq_ui
- [verk](https://github.com/edgurgel/verk) al igual que Exq es compatible con jobs de Resque y Sidekiq
Existen otras opciones, sin embargo, son proyectos que no son tan populares y estan parcialmente abandonados. Si te aventuras a utilizarlos ten en cuenta que esto puede traducirse en deuda tecnica.

## Conclusión

Gracias a la OTP en Elixir contamos con una amplia gama de herramientas que nos facilitan el procesamiento concurrente y que podrian evitarnos incluir dependencias de terceros. En este post solo mencione algunas de ellas, pero valdría la pena que las revisaras por tu cuenta.

- [Task](https://hexdocs.pm/elixir/Task.html)
- [GenServer](http://elixir-lang.org/getting-started/mix-otp/genserver.html)
- [GenStage](https://hexdocs.pm/gen_stage/GenStage.html)
- [Supervisor](http://elixir-lang.org/getting-started/mix-otp/supervisor-and-application.html)
- [OTP](http://erlang.org/doc/)

[Fuente](https://sipsandbits.com/2020/08/07/do-we-need-background-jobs-in-elixir/)
