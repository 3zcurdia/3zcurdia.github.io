---
layout: post
lang: es-MX
title: "Ampwire Release"
description: "Tu musica, exactamente como fue masterizada."
date: 2026-10-27
cover: /images/neon.png
image:
  path: /images/neon.png
  alt: "Ampwire neon theme"
  width: 1946
  height: 1352
tags:
  - release
  - music
  - audiophile
  - hi-fi
  - AI assisted
---

¿Te acuerdas del 2000?

Todos usábamos el mismo reproductor: Winamp. Una ventana pequeña, un ecualizador de bandas que movías aunque no supieras bien qué hacías, y tu colección de MP3 tuya: en tu disco, sin comerciales y sin pedirle permiso al internet.

Winamp había nacido en 1997 ([Wikipedia](https://en.wikipedia.org/wiki/Winamp)); la versión 2 llegó en septiembre de 1998 y para el 2000 ya sumaba más de 25 millones de usuarios registrados. Era el reproductor del milenio.

En honor a ese reproductor tan amado, hoy lanzo **Ampwire: un reproductor hi-fi con interfaz en la terminal, donde tu música suena exactamente como fue masterizada** ([sitio](https://ampwire.ezcurdia.dev)).

## ¿Y si tu música no es tuya?

No me malentiendas: amo el streaming. Spotify y Apple Music te dan todas la musica del mundo en el bolsillo; para los estrenos, la calidad ya es decente, y el internet de banda ancha ayuda.

Pero hay una pregunta incómoda que el catálogo infinito esconde.

Lo que escuchas depende del ancho de banda que tengas en ese momento y del máster que ellos tengan disponible. Y sobre todo: **nada de eso es tuyo**. No eres dueño de tu biblioteca; la rentas mes a mes.

## Mi torre de CDs empolvada

Yo sí tuve esa biblioteca: los discos que compré hace años, la torre junto al estéreo con suerte convertida a MP3 hace tiempo, y la carpeta de MP3 que fui acumulando, hoy empolvada en un disco.

Y ahora que puedo recodificarla a lossless (FLAC), el streaming no me sirve.

Si bien para los melómanos, un CD ripeado en FLAC no es la mejor calidad posible. Muchas veces es la única que existe: los artistas no siempre tienen los recursos ni el incentivo económico para remasterizar sus viejas producciones y subirlas a una plataforma que no les garantiza nada. Disponible no es lo mismo que fiel.

Sitios como [HDtracks](https://www.hdtracks.com/) hoy te dejan comprar álbumes en alta resolución. El problema que me quedaba era dónde reproducirlos.

## Mi motivacion

Probé de todo. Los reproductores de código cerrado tienen *features* que nunca me aseguraban una reproducción fiel: no puedo auditar lo que hacen con la señal. Y los de código abierto… ninguno me puso en ese punto de decir: disfruto este reproductor.

No soy ingeniero de audio, ni pretendo serlo. Pero sé lo que quiero oír: el archivo que tengo, no una versión "más conveniente" del archivo que tengo, y lo mejor puedo hacerlo.

## El archivo que tienes es el que suena

Esa es toda la filosofía de Ampwire: **el archivo que tienes es el que suena**.

Sin transcodificación. Sin resampleo. Sin normalización silenciosa. Los bytes de tu disco o de tu servidor se decodifican una vez, en local, y se reproducen a la resolución y los canales propios de cada canción. Si el dispositivo no puede con ese formato exacto, la canción se reporta como no reproducible en vez de convertirse a escondidas.

Y con la honestidad que aprecio: eso describe Ampwire. El mixer del sistema PipeWire, CoreAudio, el Bluetooth todavía puede resamplear camino al DAC, y Ampwire no finge lo contrario. Las canciones que comparten tasa de muestreo y canales se unen sin cortes, sin clics, sin reabrir el dispositivo: *gapless* de verdad.

## Ampwire: Winamp 2 sin el equipaje

Ampwire toma la anatomía de Winamp 2 player, espectro, ecualizador de 10 bandas playlist y nada más. No es un *port*, ni un clon, ni un *skin*: la interfaz, el motor y la biblioteca están escritos desde cero para la terminal, con un marco cyberpunk retro digno de btop.

Todo en una sola vista, todo con el teclado: espacio para play/pausa, `l` para abrir, `j` para Jellyfin, `/` para buscar, `?` para el keymap, y cada acción se puede remapear en `config.toml`. Lee FLAC, WAV, MP3 y M4A.

Sí, la terminal intimida a muchos. Pero las TUI de hoy son muy buenas más ligeras y con menos distracciones que una GUI tradicional, y sistemas operativos como [Omarchy](https://omarchy.org/), el Arch + Hyprland opinionado de DHH, ya adoptaron este estilo visual.

## Sin portadas, a propósito

Como reproductor del milenio que es, Ampwire no trae portadas, ni videos, ni letras para cantar como karaoke. Es simple y sencillamente un reproductor de audio. Como debe de ser.

Y es local primero: tus archivos suenan sin internet y sin pedirle metadatos a nadie. Si tienes red, hay dos fuentes opcionales por el mismo camino de decodificación: tu biblioteca Jellyfin completa con `j`, o un *share* SMB como `smb://nas/Music`, sin montajes raros, siempre pidiendo el archivo original, nunca un transcode.

> Dueño de tus archivos, dueño de tu música.

## Un *pet project* con neón

Con este proyecto no pretendo competir con las grandes reproductores de musica. Es un *pet project* para una necesidad personal: un reproductor que se adecue a mi.

Ademas Ampwire es compatible con Omarchy desde el inicio y sigue el tema activo del sistema. En Mac funciona con el tema neón, con ese *look* cyberpunk que yo quería, aunque también hay ámbar, *matrix* y *synthwave* para elegir.

Me llena de orgullo haberlo construido en los últimos días. Sí, con inteligencia artificial creo que eso no le quita el mérito, porque este es el reproductor tiene  exactamente lo que yo queria para volver a disfrutar mi biblioteca.

Si quieres probarlo, visita [ampwire.ezcurdia.dev](https://ampwire.ezcurdia.dev). El [código](https://github.com/3zcurdia/ampwire) es MIT.

Desempolva tus archivos esta noche. Vuelve a ser dueño de tu música.
