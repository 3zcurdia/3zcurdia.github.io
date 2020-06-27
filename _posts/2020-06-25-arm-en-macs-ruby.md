---
layout: posts
title: Ruby Developer en ARM Macs
description: ARM-Based desktop desde la perspectiva del developer
---

Hace unos días Apple reveló sus planes de integrar procesadores con arquitectura ARM en sus equipos de escritorio, dejando a un lado los procesadores de Intel con  x86. Pero ¿qué significa esto para nosotros los developers?.

Hoy, en la gran mayoría de proyectos, no nos preocupa pensar en la arquitectura a la cual será destinado nuestro software. Esta carga  la llevan los compiladores que actualmente nos permiten distribuir nuestro software para distintas plataformas. Lo cual no significa que dejemos desatendido el problema en el mediano y largo plazo.

## ARM esta en todos lados

Primero que nada hablemos del elefante en el cuarto. La arquitectura ARM está en todos lados, desde nuestros dispositivos móviles hasta nuestros vehículos, e incluso en nuestras consolas y tarjetas gráficas. Esto debido a que el modelo de negocio de ARM no es la manufactura, sino el diseño y licenciamiento de sus procesadores. Por ello, compañias como AMD, Qualcom, Nvida, Nintendo, Apple, entre otros pueden tener sus propios chips a la medida a un bajo costo. Además que con el inernet de las cosas, los fabricantes de gadgets tienen suficiente poder de procesamiento a un bajo consumo de energía. Y es por ello que en la última década ha explotado este mercado, y seguramente hay un procesador ARM cerca de ti.

## Lenguajes de Alto nivel

La gran mayoría de nosotros trabajamos con lenguajes de muy alto nivel y en nuestro trabajo del día a día no nos enfocamos en cuestiones de bajo nivel, como compatilibildad para distintos procesadores. Como ya mencioné antes, esta carga de trabajo se lo dejamos a los compiladores, los cuales nos permiten tener binarios para cualquier arquitectura. En el caso de Java, con la introducción de Android, su la maquina virtual tuvo que ser capaz de funcionar en procesadores ARM y lo único que hizo la comunidad de desarrollo fue adaptar el ecosistema a recursos limitados y mejorar el perfomance. En el caso de lenguajes que dependen de un intérprete, como es el caso de Ruby o Python, funcionan perfectamente bien en sistemas embebidos o en la Paspbery pi. Inclusive en Japón, el uso de Ruby se enfoca más en este tipo de sistemas. Así que este cambio no debería preocuparnos a la gran mayoría.

## Dependencias de terceros

Sin embargo, no todo el codigo que producimos viene de nuestras manos. Muchas veces dependemos de el trabajo de otros, que a su vez depdenden de otros y así sucesivamente. Esta práctica del software libre nos ha facilitado la vida y gracias a ella hemos evitado reinventar la rueda en cada proyecto. Sin embargo, es posible que tengamos dependencias que estén atadas a cierta arquitectura, y esto puede estar pasando sin que nos demos cuenta.  
Para evitarlo tenemos que probar nuestro código en distintas plataformas. La opción más accesible sería probar nuestro proyecto de producción en una RaspberryPI o BeagleBone. Tal vez nuestro software require mucho más poder de procesamiento, pero por lo menos sabremos si en un futuro cercano nuestra dependencias funcionan, o si necesitamos hacer ajustes.
Pero funciona en mi local
Para aquellos que estan familizazados con esta frase, "Brace yourself" porque si eres backend developer, es posible que lo digamos aun mas amenudo de lo que estamos acostumbramos. Ya que la diferencia en el set de instrucciones de nuestros ambientes de desarrollo con nuestros ambientes de producción será considerable. Aunque si hacemos la transición bien, los problemas en ambientes de desarrollo podrían ser molestos pero manejables.
Afortunadamente, el desarrollo movil se vería beneficiado ya que las applicaciones estarían desarrolladas en ambientes muy cercanos a los dispositivos móviles. Tanto el emulador de Android y el simulador de iOS tendrían una ventaja significativa.
¿ARM en el server?
Actualmente en el backend nuestros proyectos funcionan en la nube ya sea de Amazon, Google, u otro. Y si bien, el mercado de centros de datos esta enteramente dominado por Intel, esto no quiere decir que estas compañias de servicios en la nube no esten buscando alternativas con un mejor costo beneficio. En términos económicos reducir costos de energía y refrigeración pueden tener un gran impacto en las utilizades de estas compañias. Ya que alimentar y mantener a una temperatura de operación óptima estas instalaciones es realmente costoso. Por lo que en un futuro cercano sea más común ver opciones "eco-frendly" en el backend, sin la necesidad de sacrificar performance.
En conclusión ARM es una tecnología con mas de 30 años en el mercado, que en la ultima década se ha incrustado en diversas industrias. Y gracias a su eficiencia térmica y consumo de energía, es muy atractiva para un futuro donde la eficiencia está por encima del performance en bruto. Y no debe  tomarnos por sorpresa este cambio tecnológico, porque nos guste o no Apple, lidera las tendencias en el mercado.


[original](https://sipsandbits.com/2020/06/26/arm-based-macs-from-the-developers-perspective/)
