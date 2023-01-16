---
layout: post
title: Los simbolos inmortales
description: Lo que el recolector de basura de ruby jamas limpiara
date: "2021-05-20T18:00:00-06:00"
tags:
  - elixir
  - ruby
---

#### TL;DR; 
> Siempre Valida los nombres de los métodos admitidos cuando realices metaprogramación.

En ruby es muy común usar símbolos para todo, casi todo, ya que son más eficientes a la hora de realizar búsquedas o comparaciones que simples cadenas. Y gracias al recolector de basura no nos preocupamos por las asignaciones de memoria que usan nuestros símbolos. Sin embargo, hay un escenario en el que el recolector de basura los ignora y habilita "símbolos inmortales". El cual nunca será eliminado por el recolector de basura y vivirá para siempre en la memoria. Hagamos una pequeña prueba, usaremos ObjectSpace para fines prácticos y en este caso, solo nos enfocaremos en símbolos y cadenas.

En la ejecución tenemos el siguiente resultado

```ruby
require 'objspace'
require 'SecureRandom'

puts ObjectSpace.count_objects.slice(:T_SYMBOL, :T_STRING)

10.times { SecureRandom.hex.to_sym }

puts ObjectSpace.count_objects.slice(:T_SYMBOL, :T_STRING)

GC.start

puts ObjectSpace.count_objects.slice(:T_SYMBOL, :T_STRING)
```

Como podemos ver al principio tenemos varias cadenas y símbolos cuando llamamos a SecureRandom.hex instanciamos una cadena y luego se convierte en un símbolo, ya que no se usa ninguno, el recolector de basura elimina estos símbolos y algunas otras cadenas.

Ahora, supongamos que tenemos algo de metaprogramación en nuestro código, para lo cual usaremos `method_missing`, `send` y `define_method`

```ruby
require 'objspace'
require 'SecureRandom'

puts ObjectSpace.count_objects.slice(:T_SYMBOL, :T_STRING)

class Inmortal
  def method_missing(method, *args, &block)
    create_method(method)
    send(method)
  end

  def create_method(name)
    self.class.define_method(name) { "method_#{name}/0" }
  end
end

my_inmortal = Inmortal.new

10.times { my_inmortal.send(SecureRandom.hex) }

puts ObjectSpace.count_objects.slice(:T_SYMBOL, :T_STRING)

GC.start

puts ObjectSpace.count_objects.slice(:T_SYMBOL, :T_STRING)
```

Y tenemos como resultado

```shell
$ ruby inmortal.rb
{:T_SYMBOL=>28, :T_STRING=>10107}
{:T_SYMBOL=>38, :T_STRING=>10179}
{:T_SYMBOL=>28, :T_STRING=>7787}
```

¿Que pasó aquí? Cuando generamos 10 nuevos símbolos que nunca generamos. Para depurar agregaremoa a `method_missing`

```ruby
   def method_missing(method, *args, &block)
    puts method.class
    create_method(method)
    send(method)
  end
```

y ahora pasa esto

```shell
{:T_SYMBOL=>28, :T_STRING=>10135}
Symbol
Symbol
Symbol
Symbol
Symbol
Symbol
Symbol
Symbol
Symbol
Symbol
{:T_SYMBOL=>38, :T_STRING=>10144}
{:T_SYMBOL=>38, :T_STRING=>7793}
```

Ok, aparentemente `method_missing` está recibiendo un símbolo, ok pero ¿quién lo está enviando?, investiguemos dentro del método `send`

```ruby
  def send(method, *args, &block)
    puts method.class
    super
  end
```

y tenemos

```shell
$ ruby inmortal.rb
{:T_SYMBOL=>28, :T_STRING=>10152}
String
Symbol
String
Symbol
String
Symbol
String
Symbol
String
Symbol
String
Symbol
String
Symbol
String
Symbol
String
Symbol
String
Symbol
{:T_SYMBOL=>38, :T_STRING=>10164}
{:T_SYMBOL=>38, :T_STRING=>7794}
```

Por lo tanto, el método `send` se llama dos veces, la primera vez como una cadena y luego llama al `metho_missing` y la convierte a al símbolo. Esto tiene sentido ya que la documentacion dice

> Send: Invokes the method identified by symbol, passing it any arguments specified. When the method is identified by a string, the string is converted to a symbol.

De acuerdo, ya determinamos quién se convierte en símbolos, pero ¿por qué el recolector de basura nunca elimina esos símbolos?

Vamos a profundizar, si modificamos nuestra prueba para ver los métodos definidos en nuestra clase tendremos algo mas de informacion a detalle

```ruby
puts my_inmortal.methods.count
10.times { my_inmortal.send(SecureRandom.hex) }
puts my_inmortal.methods.count
```
y conseguiremos

```shell
$ ruby inmortal.rb
{:T_SYMBOL=>28, :T_STRING=>10134}
60
70
{:T_SYMBOL=>38, :T_STRING=>10228}
{:T_SYMBOL=>38, :T_STRING=>7793}
```

Como podemos ver, nuestra instancia de clase tiene 10 nuevas definiciones de métodos que son símbolos, por lo tanto, el recolector de basura ignora esas referencias ya que pertenecen a una instancia de objeto. Incluso si la instancia del objeto se elimina por completo, la referencia a los métodos de ese objeto permanecen para siempre.

Entonces, ¿cómo podemos evitar estas pérdidas de memoria? Simplemente evitando la creación de métodos no deseados

```ruby
require 'objspace'
require 'SecureRandom'

puts ObjectSpace.count_objects.slice(:T_SYMBOL, :T_STRING)

class Inmortal
  def method_missing(method, *args, &block)
    super unless method.start_with?('m_')
    create_method(method)
    send(method)
  end

  def respond_to_missing?(method, include_private = false)
    method.start_with?('m_') or super
  end

  def create_method(name)
    self.class.define_method(name) { "method_#{name}/0" }
  end
end

my_inmortal = Inmortal.new

10.times { my_inmortal.send("m_#{SecureRandom.hex}") }
10.times { my_inmortal.send(SecureRandom.hex) rescue nil }

puts ObjectSpace.count_objects.slice(:T_SYMBOL, :T_STRING)

GC.start

puts ObjectSpace.count_objects.slice(:T_SYMBOL, :T_STRING)
```

Resultando con algo asi

```shell
$ ruby inmortal.rb
{:T_SYMBOL=>28, :T_STRING=>10145}
{:T_SYMBOL=>48, :T_STRING=>10204}
{:T_SYMBOL=>38, :T_STRING=>7805}
```

Como podemos ver, cuando validamos tanto en "respond_to_missing" como en "method_missing" se evita la creación de un nuevo método, por lo tanto no habrá símbolos "inmortales", entonces solo los requeridos para la instancia.

Basicamente prodrias hacer una bomba de memoria en ruby haciendo algo asi

```ruby
require 'SecureRandom'

class Bomb
  def method_missing(meth, *args, &blk)
    self.class.send(:define_method, "is_#{meth}?") { true }
    send("is_#{meth}?")
  end
end

loop { Bomb.new.send(SecureRandom.hex) }
```

Asi que ya lo sabes ten cuidado con el uso de simbolos cuando hagas metaprogamación.



