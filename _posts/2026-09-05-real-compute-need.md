---
layout: post
title: "La demanda de poder de cómputo que nunca llegó"
description: "Quince años de avance tecnológico, ¿para qué?"
date: 2026-09-05
tags:
  - hardware
  - análisis
  - llms
  - apple silicon
  - AI assisted
---

## La PC de 100 dólares

Hace poco compré una Lenovo ThinkCentre M920Q usada por alrededor de 100 dólares: la típica mini-PC de oficina con un Intel Core i5-8500T de 6 núcleos y 16 GB de RAM.
Thinkers y homelabs la adoran, pero en esta ocasión la adquirí para mi padre, quien toda su vida ha utilizado la computadora para tareas básicas de ofimática. Me pareció un buen trato dado que su computadora tiene más de 10 años y está teniendo problemas de rendimiento, por lo que este upgrade mejoró su experiencia.

Este equipo en Geekbench 7 marca alrededor de 1,235 puntos en single core y 5,138 en multicore. En comparación con mi daily driver, una Mac Mini con chip M4 Pro, esta última es 3.2 veces más rápida por núcleo y 4.4 veces en multicore ([comparativa aquí](https://browser.geekbench.com/v7/cpu/compare/205229?baseline=201516)). Para la mayoría de las personas, la ofimática básica cubre sus necesidades, si bien no es el equipo más reciente: ninguna hoja de cálculo o procesador de texto se queja. Y si encima le conectara una GPU usada, técnicamente podría correr juegos AAA a 1080p en calidad baja.

Lo que me lleva a pensar: si una máquina de 100 dólares de 2018 cubre el 95% de los casos de uso, ¿para qué sirvió el progreso tecnológico de los últimos años?

## Lo que el software de verdad pide

En 2010, Office arrancaba con un procesador de 500 MHz y 256 MB de RAM. Hoy, Office 2024 y Microsoft 365 piden 1.6 GHz, 2 núcleos y 4 GB. El requerimiento mínimo se incrementó unas tres veces en quince años. A la par, Windows mantuvo el mismo requerimiento durante ese periodo ("1 GHz", de Windows 7 a Windows 10); fue hasta Windows 11 que se incrementó el requerimiento mínimo: 4 GB, chip TPM 2.0 y, por primera vez, una lista de CPUs compatibles que empieza en la 8ª generación de Intel (2017).

El escenario para los creativos no dista mucho: Final Cut Pro pide 8 GB de RAM (16 recomendados), y Blender, el estándar abierto del 3D, pide 4 núcleos con SSE4.2, 8 GB de RAM y 2 GB de VRAM. ¿Y para programar? Un IDE moderno pide 4 núcleos y 8 GB. Todo eso lo cumple, con margen sobrado, una ThinkCentre de 100 dólares; y ni hablemos de Linux, que le da más potencia a la computadora.

Los requisitos mínimos llevan congelados desde ~2016; solo los "recomendados" apenas se incrementaron.

## El maratón del silicio

Pongamos por ejemplo a Intel y sus procesadores de los últimos quince años. Seis años estancados en 4 núcleos (2009–2017) hasta que AMD Ryzen llegó y asustó al mercado con procesadores de 6 y 8 núcleos; después el desarrollo en multicore se aceleró, llegando a 2021 con dos generaciones en doce meses y la arquitectura híbrida P+E; y en 2024 el adiós al apellido "i": bienvenida la era Core Ultra, sin Hyper-Threading y con DDR5 obligatoria. Aquí les dejo la tabla:

| Año | Generación Intel | Gama media (i5 / i7) | Núcleos/hilos (i5 / i7) | Frec. base media, GHz (i5 / i7) | Turbo máx., GHz (i5 / i7) | Memoria |
|---|---|---|---|---|---|---|
| 2009–10 | 1ª — Nehalem | i5-750 / i7-870 | 4C/4T / 4C/8T | 2.66 / 2.93 | 3.2 / 3.6 | DDR3-1333 |
| 2011 | 2ª — Sandy Bridge | i5-2500K / i7-2600K | 4C/4T / 4C/8T | 3.3 / 3.4 | 3.7 / 3.8 | DDR3-1333 |
| 2012 | 3ª — Ivy Bridge | i5-3570K / i7-3770K | 4C/4T / 4C/8T | 3.4 / 3.5 | 3.8 / 3.9 | DDR3-1600 |
| 2013 | 4ª — Haswell | i5-4670K / i7-4770K | 4C/4T / 4C/8T | 3.4 / 3.5 | 3.8 / 3.9 | DDR3-1600 |
| 2015 | 6ª — Skylake | i5-6600K / i7-6700K | 4C/4T / 4C/8T | 3.5 / 4.0 | 3.9 / 4.2 | DDR4-2133 (nace) |
| 2017 | 7ª — Kaby Lake | i5-7600K / i7-7700K | 4C/4T / 4C/8T | 3.8 / 4.2 | 4.2 / 4.5 | DDR4-2400 |
| 2017 | 8ª — Coffee Lake | i5-8600K / i7-8700K | 6C/6T / 6C/12T | 3.6 / 3.7 | 4.3 / 4.7 | DDR4-2666 |
| 2018–19 | 9ª — Coffee Lake R | i5-9600K / i7-9700K | 6C/6T / 8C/8T (sin HT) | 3.7 / 3.6 | 4.6 / 4.9 | DDR4-2666 |
| 2020 | 10ª — Comet Lake | i5-10600K / i7-10700K | 6C/12T / 8C/16T | 4.1 / 3.8 | 4.8 / 5.1 | DDR4-2933 |
| 2021 | 11ª — Rocket Lake | i5-11600K / i7-11700K | 6C/12T / 8C/16T | 3.9 / 3.6 | 4.9 / 5.0 | DDR4-3200 |
| 2021 | 12ª — Alder Lake | i5-12600K / i7-12700K | 10C/16T (6P+4E) / 12C/20T (8P+4E) | 3.7 / 3.6 (P) | 4.9 / 5.0 | DDR5-4800 (nace) |
| 2022 | 13ª — Raptor Lake | i5-13600K / i7-13700K | 14C/20T (6P+8E) / 16C/24T (8P+8E) | 3.5 / 3.4 (P) | 5.1 / 5.4 | DDR5-5600 |
| 2023 | 14ª — Raptor Lake R | i5-14600K / i7-14700K | 14C/20T (6P+8E) / 20C/28T (8P+12E) | 3.5 / 3.4 (P) | 5.3 / 5.6 | DDR5-5600 |
| 2024 | Core Ultra 200S — Arrow Lake | Ultra 5 245K / Ultra 7 265K | 14C/14T (6P+8E) / 20C/20T (8P+12E), sin HT | 4.2 / 3.9 (P) | 5.2 / 5.5 | DDR5-6400 (CUDIMM) |
| 2025 | Arrow Lake no‑K (6‑ene) | Ultra 5 245 / Ultra 7 265 | 14C/14T (6P+8E) / 20C/20T (8P+12E), 65 W | 3.5 / 2.4 (P) | 5.1 / 5.2 | DDR5-6400 |
| 2026 | Arrow Lake Refresh "Plus" (26‑mar) | Ultra 5 250K / Ultra 7 270K Plus | 18C/18T (6P+12E) / 24C/24T (8P+16E) | 4.2 / 3.7 (P) | 5.3 / 5.5 | DDR5-6400 |
| 2026 (prevista) | 16ª — Nova Lake (Core Ultra 4) | gama media sin anunciar | hasta 52C | — | — | LGA 1954, Intel 18A |

*\*La 5ª generación (Broadwell, 2014–2015) apenas llegó al escritorio: solo un par de modelos sueltos, como el i5-5675C.*

## Lo que los power users realmente usan

Dentro del cómputo es bien sabido que los gráficos siempre han sido la carga más demandante; por ello, la [Encuesta de Hardware de Steam](https://store.steampowered.com/hwsurvey/) funciona como el mejor censo del segmento más exigente del planeta:

- Alrededor del 33% de los Intel está en el rango de 2.3 a 2.99 GHz, y solo ~2.7% corre a más de 3.7 GHz: las frecuencias de reloj en condiciones reales son mucho más bajas que las cifras en modo *boost*.
- Los sistemas de 4, 6 y 8 núcleos suman ~67.9%; es decir, aproximadamente dos de cada tres jugadores utilizan 8 núcleos o menos. La tecnología Hyper-Threading está presente en el 87.86% de los sistemas.
- La GPU más común sigue siendo la **RTX 3060… de 2021** (3.76%).
- Las seis tope de gama de tres generaciones —3080, 3090, 4080, 4090, 5080, 5090— **suman ~5% entre todas**. Las "90", juntas: 1.5%.
- El 50.5% juega a 1080p; 4K, apenas 5%. Dos tercios tienen 8 hilos o menos. La RAM modal: 16 GB (41%), con 32 GB pisándole los talones (37%).

Si incluso los gamers, a quienes se consideraría los usuarios más hambrientos de cómputo, viven en el mid-range de hace 3 a 5 años, ¿qué clase de software podría demandar más poder de procesamiento que el que ya existe?

## La pieza de software que faltaba

No existe pieza de software más ineficiente que la IA —en concreto, los LLMs—: para lograr capacidades superiores requieren una cantidad exorbitante de VRAM, además de alta velocidad de transferencia (hablamos de terabytes en capacidad y ancho de banda). Para que un modelo de lenguaje local (cuantizado) funcione de forma útil se requieren al menos 16 GB de VRAM; poniéndolo en contexto, es como tener toda la Wikipedia cargada en memoria (~9 GB) para poder hacer el resumen de este artículo que estás leyendo.

Esta pieza de software que todos quieren, con el pretexto de la privacidad y el control sobre los datos, justifica la aparición de monstruos de procesamiento como el reciente lanzamiento del Mac Studio con **M5 Ultra**: 30 núcleos de CPU, 96 GB de memoria unificada (configurable a 512 GB), 1.2 TB/s de ancho de banda, desde $5,499 ([specs](https://www.apple.com/mac-studio/specs/)). Eso no lo necesita un editor de video 4K: un equipo pro de hace 6 años puede manejar la mayoría de los flujos creativos. El Ultra existe para una sola cosa del mundo real: **correr modelos de IA gigantes en local**.

Del lado PC, el mismo patrón se repite: la RTX 5090 y sus 32 GB de VRAM solo representan el 0.41% de los gamers. El segmento conocido como entusiasta apenas tiene la capacidad de correr modelos de lenguaje pequeños como Qwen3 27B y darle un uso real; por más que queramos correrlo en una 5060 Ti, sus 3 tok/s no son suficientes para correr flujos agénticos.

## La aritmética incómoda de la IA local

Entonces, ¿la IA forzará la innovación? Hasta el momento es el único candidato real: la primera carga de trabajo nueva y pesada en quince años. Sin embargo, una suscripción a un modelo de frontera (~$200/mes) cuesta alrededor de $2,400 USD al año; una M5 Ultra de $5,499 equivale a 2.3 años de suscripción. Mientras estos precios se mantengan, la nube sigue ganando.

Por otro lado: primero, esos precios no representan el costo real; están subsidiados por la burbuja de capital. Segundo: los modelos abiertos avanzan más rápido que los cerrados. Qwen3 27B marca ~52 puntos en [Artificial Analysis](https://artificialanalysis.ai); Claude Opus 4.5/4.6 de Anthropic, los modelos de frontera del año pasado, se quedan en ~48 puntos, apenas 4 puntos por debajo. En otras palabras: **calidad de frontera de hace un año, en un modelo que cabe en 24 GB de VRAM** — una RTX 3090 usada de ~$800, o el Mac Studio base con M5 Max (36 GB, ~$3,000).

Cuando la burbuja estalle y las suscripciones suban al costo real (~$400/mes, por ejemplo), el Ultra de $5,499 se pagaría solo en ~14 meses y el de $3,000 en menos de 8; ese capricho pasa a ser una inversión. La élite que hoy compra el Ultra no está comprando poder: **está pagando por beta-testear el nivel gratis que todos correremos en local mañana.**

## La demanda que nunca llegó

Por eso el FOMO de los últimos lanzamientos se siente tan vacío. No hay una tarea cotidiana que la mayoría no pueda resolver con hardware de hace cinco años, y ni el top 5% de los gamers aprovecha el salto generacional. Quince años de avance tecnológico no trajeron ninguna demanda nueva para el usuario común: la única carga que de verdad pide más poder es la IA, y los equipos de marketing harán lo posible por hacerte sentir que la necesitas hoy. Pero no la necesitas: la única razón real para comprar ese hardware es la IA del futuro, y esa todavía no existe. Puedes esperar.
