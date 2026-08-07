---
layout: post
title: "LLMs vs Examen de Admisión UNAM"
description: ¿Puede una Inteligencia Artificial entrar a la Universidad por mérito propio?
image: /images/unam-vs-llm.png
date: 2026-08-05
tags:
  - academia
  - analisis
  - llms
  - AI assisted
---

¿Puede una Inteligencia Artificial aprobar el examen de admisión de la Universidad Nacional Autónoma de México (UNAM)? Tras la controversia sobre los resultados del examen a nivel licenciatura 2026, donde claramente aspirantes utilizaron herramientas para hacer trampa, entre ellas el uso de la IA, el debate trascendió rápidamente en muchas aristas. Sin embargo, ninguna de ellas respondía la pregunta central: ¿Puede una IA responder el examen de admisión de la UNAM?

Por ello me embarqué en diseñar un pequeño benchmark contra un examen simulacro. Mi objetivo era someter los Modelos Grandes de Lenguaje (LLMs) a la prueba más conocida, rigurosa y estandarizada en el ámbito académico mexicano a nivel bachillerato: el examen de admisión UNAM.

Los resultados son interesantes, ofreciendo una radiografía precisa no solo de la capacidad actual de los modelos, sino también de sus limitaciones culturales, lingüísticas y estructurales.

## Metodología del Benchmark: Precisión como Fundamento

Para garantizar el rigor de esta prueba, me basé en dos pilares metodológicos innegociables: una IA debe contestar una pregunta solo con el contexto necesario, y al menos debe poder contestar mas de una pregunta para ser considerada funcional.

### 1. Extracción de Datos y Simulación

Se utilizó un examen simulacro completo que replicó la estructura temática del ingreso a nivel superior de la UNAM. Los reactivos incluyen evaluaciones en diez áreas académicas críticas, desde la Biología y la Química hasta la Historia de México y la Filosófia.

### 2. Modelos Evaluados

Se evaluaron modelos en diversos estados:

*   **Cerrados:** Modelos creados por las Big Tech de Silicon Valley, incluyendo GPT Terra, Grok 4.5, Gemini Flash y sus versiones lite.
*   **Abiertos de nube (Open Weights):** Modelos de código abierto ejecutados en proveedores de nube, cuyo costo-beneficio pone a prueba a los grandes laboratorios de IA.
*   **Local:** Modelos de código abierto ejecutados en hardware local (por ejemplo, Qwen 3.6 o Gemma 4) que demuestran las capacidades de los LLMs en configuraciones de escritorio.

### 3. Métrica Cuantitativa (Score y Puntuación)

Cada ejecución fue catalogada bajo cuatro indicadores principales, permitiendo un análisis multidimensional:

*   **Score (%):** El porcentaje global de respuestas correctas sobre el total del examen.
*   **Promedio (Avg):** El puntaje cuantitativo obtenido sobre el máximo teórico posible de 120 puntos.
*   **Resultados por Área y Materia:** El desglose específico de aciertos en cada una de las diez materias, crucial para identificar fortalezas y debilidades.
*   **Esfuerzo (Effort Level):** Se registró el nivel de razonamiento configurado para la ejecución (`none`, `low`, `medium`, `high`), un parámetro esencial para entender si el aumento de la complejidad computacional se traduce en mayor acierto.

El [código](https://github.com/3zcurdia/pumabench) fuente y los [resultados](https://puma-bench.vercel.app) de este benchmark están disponibles públicamente.

## Resultados Generales

Todos los modelos han demostrado una capacidad asombrosa, superando fácilmente el 90% de aciertos. Sin embargo, parece existir un límite del 95% donde el razonamiento puro de estos lenguajes está limitado.

### La Cima del Rendimiento (95%+ Score)

Los mejores modelos que alcanzaron este nivel se situaron en el 95% con 115 aciertos.

*   **Líder Individual:** El modelo **Xiaomi MIMO v2.5**, evaluado con esfuerzo medio, alcanzó el mejor resultado global: 95.8% de *score* y un promedio de 115 puntos. Su dominio fue casi absoluto, destacando que el área que marcó la diferencia fue con la interpretación del español y filosofía. Siendo el modelo más balanceado.
*   **El Club del 95%:** En un nivel inmediatamente inferior, encontramos ejecuciones colectivas que también alcanzaron 95% de aciertos. Entre estos contendientes se encuentran: **DeepSeek v4 Flash**, **Grok 4.5**, **GPT 5.6-Terra**, **Gemini 2.5 Flash Lite**. De los cuales se destacan **Gemini 2.5 Flash Lite** y **DeepSeek v4 Flash**, que pese a su tamaño, son los más rápidos y económicos que alcanzan el 95% de aciertos.

Este punto es crítico: cuando se trata de las carreras más selectivas (como Medicina, que exige puntajes alrededor de los 114 puntos), la IA se mantiene en contienda. El 5% restante solo le corresponde al ser humano, ya que los modelos de lenguaje demuestran que el conocimiento es vasto, pero con sesgos marcados, y aún los gigantes tienen puntos ciegos.

### La Potencia de los Modelos Locales (Open Weights)

Quizás el hallazgo más prometedor fue la brillantez de los modelos locales, aquellos con menos de 27 mil millones de parámetros (27B). Demostraron que la calidad del entrenamiento y el tamaño no son los únicos determinantes:

*   **Qwen 3.6 (35B con 3B activos):** Un modelo MOE (Mixture of Experts) alcanzó un impresionante 94.17% de aciertos, situándose a una distancia mínima del máximo global.
*   **DeepSeek v4 Flash 0731:** Un modelo denso cuantizado, alcanzó entre 93% y 94%. Que aunque requiere alrededor de 128 GB de VRAM, aún se encuentra en las posibilidades de un consumidor final.

Estos hallazgos sugieren que la sofisticación académica no está colonizada exclusivamente por las arquitecturas propietarias de las gigantes tecnológicas, sino que es accesible mediante diseños eficientes y ejecutables localmente.

## Análisis Profundo: La Tríada Score, Esfuerzo y Costo

La mera cifra del puntaje es insuficiente; para comprender la eficiencia de un LLM, debemos analizar su desempeño en función del esfuerzo computacional y el coste operativo.

### La Dinámica Esfuerzo vs. Rendimiento

El parámetro de "Esfuerzo" demostró que aumentar la complejidad no siempre garantiza un mejor resultado. Observamos casos donde el aumento declarado de razonamiento ("Alto" vs. "Bajo") no se tradujo linealmente en una mejora de la calidad o acierto:

*   **DeepSeek v4 Flash (Esfuerzos):** Una ejecución con esfuerzo bajo logró un 94%, mientras que su contraparte con esfuerzo medio obtuvo 93.5%. Esto pone en duda la mera correlación entre el *prompt* de esfuerzo y la calidad del resultado.
*   **Gemini 3.5 Flash:** Pese a ser una versión más actualizada, obtuvo el mismo resultado pero a mayor costo y tiempo que su antecesor Gemini 2.5.
*   **Gemma 4 e4b:** Un modelo que no requiere más de 16 GB de VRAM para una ejecución cuantizada da resultados que no distan mucho de los grandes modelos, además que en esfuerzo bajo superó a sus ejecuciones con esfuerzo medio y alto.
*   **Microsoft Phi 4:** Un modelo local que se caracteriza por ser lento, pero al no contar con capa de pensamiento, casi iguala a resultados de sus equivalentes en una fraccion del tiempo.

> Pensar más no te hace más inteligente, solo gastas más energía.

### Eficiencia y Costo: El Dilema Operacional

Mientras que el ejercicio en su fase inicial incluyó la comparación de costos y velocidad, es crucial señalar la dependencia de esta variable. Sin registros verificables de latencia total, consumo en tokens o precio aplicado a la API, cualquier conclusión sobre cuál es el modelo "más rentable" o "más rápido" queda incompleta. Sin embargo, los modelos como **DeepSeek v4 Flash** y **Gemini 2.5 Flash** han demostrado una combinación excepcional de alta velocidad y coste eficiente para mantener un rendimiento sobresaliente.

### La Leyenda Negra del Modelo Pequeño

Lejos de ser "tontos", los modelos pequeños también poseen un valor innegable. Un modelo como **Qwen 3.5 0.8B**, aunque con un 48% de aciertos promedio, logró superar el umbral medio en una prueba masiva. Al ser un examen de opción múltiple, una selección al azar produce un 25% de acertividad. Un modelo como este, que puede ser ejecutado en dispositivos móviles, tiene mayores probabilidades de acertar una pregunta, que un ave maria.

## Las Fracturas Culturales: Cuando el Idioma Falla

Los resultados más interesantes, pero también los más vulnerables a la especulación, radican en las fallas culturales e idiomáticas. Los LLMs son espejos de sus datos de entrenamiento, y estos reflejan un sesgo dominante.

### El Dominio del Inglés y las Superpotencias

La mayoría de los LLMs han sido entrenados primordialmente sobre conjuntos masivos de datos en inglés. Por ende, aunque poseen una vasta capacidad lingüística, el español a nivel bachillerato presenta un reto considerable, probablemente el sesgo en el set de datos del idioma.

Además, ciertos modelos mostraron inconsistencias notorias en Historia de México o Geografía, materias intrínsecamente ligadas al contexto hispanoamericano. Mostrando una brecha importante en la capacidad de los modelos.

### El Caso de los *Guardrails* y el Conocimiento Silenciado

Un caso curioso fue el modelo local **Apple Foundation**, liberado dentro del sistema operativo MacOS 27. El modelo obtuvo un 64.6% de aciertos, lo cual podría parecer pobre en comparación con sus contemporáneos. Sin embargo, la principal causa no fue una falta de capacidad pura. Sus estrictos mecanismos de seguridad (*guardrails*) provocaron que el sistema se negara a responder reactivos considerados "sensibles" (particularmente en Historia de México), prefiriendo activamente la precaución a la respuesta. Este caso nos enseña que un puntaje bajo puede ser también el resultado de una resistencia éticamente programada, no necesariamente incompetencia algorítmica.

### La Deuda con la Historia Local

A pesar de su vasta potencia en matemáticas y física, el desempeño fluctuante frente a la Historia de México es un llamado directo a la necesidad de diversificar los corpus de entrenamiento. Un fallo en este aspecto refleja una asimetría en la representación del conocimiento global presente en el modelo.

## Conclusión: ¿Una Potente Herramienta, pero Imperfecta?

Como herramienta, la inteligencia artificial es magnífica. En los resultados de las pruebas, todos los modelos muestran un comportamiento logarítmico que tiende al 100%, pero dado los sesgos y tipos de entrenamiento, no avanzan en ese sentido. Los modelos pequeños no distan por mucho de sus contrapartes de recursos ilimitados. Los modelos abiertos pueden tener un mejor uso que uno privado, desde customizaciones hasta implementaciones de sistemas RAG.

No cabe duda que el 10% o 5% es el factor humano, y el hecho que en todas las implementaciones de inteligencia artificial, el factor humano es clave en su éxito o fracaso. Puedes tener el modelo más inteligente de todos y aun así fallar en su implementación, ya sea por una excesiva confianza o por negligencia.
