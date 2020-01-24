---
layout: post
title: "Geolocalizacion con PostgresSQL y Rails"
description: "Implement geolocation"
date: "2017-11-11T20:55:32-06:00"
background: /assets/images/post-bg.jpg
tags:
  - rails
  - postgresql
  - geolocalization
---

## Introduccion

Actualment vemos como aplicaciones utilizan refencia geografica para algunas de sus funcionalidades.
Uno pensaria que con el hecho de guardar latitud y longitud y hacer algo de aritmetica basica seria suficiente
sin embargo existe un problema: la tierra no es plana y eso complica los calculos. Afortunadamente
existen herramientas que lo resuelven y ademas nos permiten hacer busquedas, una de estas herramientas
es PostGIS que es una extencion de PostgreSQL.

Pensemos en el siguiente escenario: supongamos que nuestra aplicacion requiere de un directorio de enfermeros geolocalizable en donde se quiere localizar al mejor y mas cercano cercano. Podriamos hacer la busqueda por medio del cliente, lo cual implicaria que pasemos todos los registros y que este realize la busqueda, este tipo de arquitectura
es perfecto si se tiene un catalogo reducido. Sin embargo no escala en el caso de millones de registros dinamicos, es por eso que realizaro del lado del servidor seria mas facil, y por medio de busquedas georeferenciadas se podria hacer un
query que resuelva esto. Si consideramos que dentro de postgres existe PostGIS seria aun mas facil implementarlas busquedas desde la base de datos, sin la necesidad de utilizar una liberia externa.

## ¿Que se necesita?

Partiendo del hecho que nuestra aplicacion es esta escrita con ruby on rails y PostgreSQL, requerimos habilitar las extenciones de PostGIS en la base de datos lo cual veremos mas adelante.

Otras de las dependencias es la gema `Rgeo` que es una libreria para el manejo de datos geoespaciales, para la cual
requerimos un par de librerias en nuestro sistema libproj-dev y libgeos-dev

## Implementacion

Lo primero que necesitamos hacer es habilitar la extencion de postgres por medio de una migracion

```ruby
  class EnablePostgis < ActiveRecord::Migration[6.0]
    def change
      enable_extension :postgis
    end
  end
```

Luego agregaremos la gema de postgis para activerecord y asi poder tener algunos helper methods en migraciones y queries

```ruby
  gem 'activerecord-postgis-adapter'
```

Para ello es necesario que en nuestro archivo `config/database.yml` cambiemos el adaptador a postgis, para la configuracion de produccion cuando no tenemos accesso a cambiar la variable de ambiente como es el caso de heroku haremos uso ruby en el archivo para remplazar postgres con postgis.

```yaml
  default: &default
    adapter: postgis
    schema_search_path: public, postgis

  production:
    <<: *default
    url: <%= ENV.fetch('DATABASE_URL', '').sub(/^postgres/, "postgis") %>
```

Una vez realizado esto nuestra aplicacion esta lista para integrar postgis, solo nos falta
un preparativo final para nuestra base de datos.

```bash
  rake db:gis:setup
```

En cuanto al tipo de datos los cuales podemos utilizar:
  - :geometry -- Any geometric type
  - :st_point -- Point data
  - :line_string -- LineString data
  - :st_polygon -- Polygon data
  - :geometry_collection -- Any collection type
  - :multi_point -- A collection of Points
  - :multi_line_string -- A collection of LineStrings
  - :multi_polygon -- A collection of Polygons


```ruby
create_table :my_spatial_table do |t|
  t.geometry :shape
  t.line_string :path, srid: 3785
  t.st_point :lonlat, geographic: true
  t.st_point :lonlatheight, geographic: true, has_z: true
end
```






- tipos de datos
- query de busqueda del elemento mas cercano

Local

Server en heroku

builpacks
  1. https://github.com/heroku/heroku-buildpack-apt
  2. heroku/ruby
- APTfile
- script que verifique que la geolocalizacion esta funcionando


## Comentartios finales

- tiene otras aplicaciones
- diferentes tipos de busqueda
- el db server no escala tanto como la app
