---
layout: post
title: "Análisis LLM vs Examen de Admisión UNAM"
description: ¿Puede una Inteligencia Artificial entrar a la Universidad por mérito propio?
image: /images/unam-vs-llm.png
date: 2026-07-11
tags:
  - academia
  - analisis
  - llms
  - AI assisted
---

¿Puede una Inteligencia Artificial aprobar el examen de admisión de la Universidad Nacional Autónoma de México (UNAM)? Esta pregunta, surge tras la controversia sobre los resultados del examen a nivel licenciatura 2026, en donde claramente aspirantes utilizaron herramientas para hacer trampa entre ellas el uso de la IA. El debate, trascendió rápidamente en muchas aristas sin embargo ninguna de ellas respondia la pregunta si una IA puede responder a la perfection y en tiempo el examen de admisión UNAM.

Por ende me embarqué en diseñar un pequeño benchmark contra un examen simulacro. Mi objetivo no fue declarar la supremacía o incompetencia de un algoritmo, sino someter los Modelos Grandes de Lenguaje (LLMs) a la prueba más conocida, rigurosa y estandarizada en el ámbito académico mexicano a nivel bachillerato: el examen de admisión UNAM.

Para llevar a cabo este ejercicio empírico exhaustivo utilize un simulacro oficial actualizado (basado en el examen 2025). Mediante un scraper, recopile al rededor de 480 preguntas correspondientes a las 4 areas. Estos datos fueron procesados por una variedad de LLMS, desde modelos masivos en la nube APIs hasta pequeños modelos locales.

Los resultados son intersante, ofreciendo una radiografía precisa no solo de la capacidad actual de los modelos, sino también de sus limitaciones culturales, lingüísticas y estructurales.

## Metodología del Benchmark: Precisión como Fundamento

Para garantizar la científica de nuestros hallazgos, el experimento se basó en tres pilares metodológicos innegociables:

**1. Extracción de Datos y Simulación:**
Se utilizó un examen simulacro completo que replicó la estructura temática del ingreso a nivel superior de la UNAM. Los reactivos incluyen evaluaciones en diez áreas académicas críticas, desde la Biología y la Química hasta la Historia de México y el Razonamiento Filosófico.

**2. Despliegue Variado de Modelos:**
Evalue modelos en diversos estados:
*   **Nube (Cloud APIs):** Ejemplos incluyen GPT Terra, Grok 4.5, Gemini Flash y variaciones de pago por uso (por ejemplo, Gemini 3.5 Flash Lite).
*   **Local (*Open Weights*):** Modelos de código abierto ejecutados en hardware comercial (por ejemplo, Qwen 3.6 o Gemma 4) que demuestran la viabilidad de los LLMs en configuraciones de escritorio.

**3. Métrica Cuantitativa (Score y Puntuación):**
Cada ejecución fue catalogada bajo cuatro indicadores principales, permitiendo un análisis multidimensional:
*   **Score (%):** El porcentaje global de respuestas correctas sobre el total del examen.
*   **Promedio (Avg):** El puntaje cuantitativo obtenido sobre el máximo teórico posible 120 puntos.
*   **Resultados por Área y Materia:** El desglose específico de aciertos en cada una de las diez materias, crucial para identificar fortalezas y debilidades.
*   **Esfuerzo (*Effort Level*):** Se registró el nivel de razonamiento configurado para la ejecución (`none`, `low`, `medium`, `high`), un parámetro esencial para entender si el aumento de la complejidad computacional se tradujo en mayor acierto.

El código fuente y la documentación de este *benchmark* están disponibles públicamente [aqui](https://github.com/3zcurdia/pumabench).


## Resultados Generales

Los datos recolectados desafían el concepto binario de "éxito o fracaso" absolutos. La realidad es mucho más matizada: los modelos avanzados han demostrado una capacidad asombrosa, obtener el 100% de aciertos es extremadamente difícil de alcanzar, al momento es algo que solo puede un ser humano alcanzar. 

### La Cima del Rendimiento (95%+ Score)

Los mejoeres modelos que alcanzaron se situaron en el 95% con 115 aciertos.

*   **Líder Individual:** El modelo **Xiaomi MIMO v2.5**, evaluado con esfuerzo medio, alcanzó el mejor resultado global: 95.8% de *score* y un promedio de 115 puntos. Su dominio fue casi absoluto salvo por algunas áreas.
*   **El Club del 95%:** En un nivel inmediatamente inferior, encontramos ejecuciones colectivas que también alcanzaron 95% de aciertos. Entre estos contendientes se encuentran: **DeepSeek v4 Flash**, **Grok 4.5**, **GPT 5.6-Terra**, **Gemini 2.5 Flash Lite**, **Gemini 3.6 Flash** y **Minimax M3**. De los cuales se destacan **Gemini 2.5 Flash Lite** y **DeepSeek v4 Flash**, que pese a su tamaño, son los mas rapidos y economicos de alcanzar el 95% de aciertos.

Este punto es crítico: cuando se trata de las carreras más selectivas (como Medicina, que exige puntajes al rededor de los 114 puntos), la IA se mantiene en contienda. Sin embargo el 5% restante para la perfección solo le corresponde al ser humano, ya que los modelos de lenguaje demuestra que el conocimiento es vasto, pero con sesgo marcado, y aun los gigantes tienen puntos ciegos.

### La Potencia de los Modelos Locales (*Open Weights*)

Quizás el hallazgo más prometedor fue la brillantez de los modelos locales, aquellos con menos de 27 mil millones de parámetros (27B). Demostraron que la calidad del entrenamiento y el tamaño no son los únicos determinantes:

*   **Qwen 3.6 (35B con 3B activos):** Un modelo MOE (Mixture of Experts) alcanzó un impresionante 94.17% de aciertos, situándose a una distancia mínima del máximo global.
*   **DeepSeek v4 Flash 0731:** Un modelo denso pero cuantizado, alcanzó entre 93% y 94%. aunque el hardware necesario para ejecutarlo es mucho más costoso, aun se encuntra en las posiblidades de un consumidor final.

Estos hallazgos sugieren que la sofisticación académica no está colonizada exclusivamente por las arquitecturas propietarias de las gigantes tecnológicas, sino que es accesible mediante diseños elegantes y ejecutables localmente.

## Análisis Profundo: La Tríada Score, Esfuerzo y Costo

La mera cifra del puntaje es insuficiente; para comprender la eficiencia de un LLM, debemos analizar su desempeño en función del esfuerzo computacional y el coste operativo.

### La Dinámica Esfuerzo vs. Rendimiento
El parámetro de "Esfuerzo" demostró que aumentar la complejidad no siempre garantiza un mejor resultado. Observamos casos donde el aumento declarado de razonamiento ("Alto" vs. "Bajo") no se tradujo linealmente en una mejora de la calidad o acierto:

*   **DeepSeek v4 Flash (Esfuerzos):** Una ejecución con esfuerzo bajo logró un 94%, mientras que su contraparte con esfuerzo medio obtuvo 93.5%. Esto pone en duda la mera correlación entre el *prompt* de esfuerzo y la calidad del resultado.
*   **Gemini 3.5 Flash Lite:** Pese a ser una versión más actualizada, obtuvo el mismo resultado pero a mayor costo que su antecesor.

### Eficiencia y Costo: El Dilema Operacional

Mientras que el ejercicio en su fase inicial incluyó la comparación de costos y velocidad, es crucial señalar la dependencia de esta variable. Sin registros verificables de latencia total, consumo en tokens o precio aplicado a la API, cualquier conclusión sobre cuál es el modelo "más rentable" o "más rápido" queda incompleta. Sin embargo, los modelos como **Gemini 2.5 Flash** han demostrado una combinación excepcional de alta velocidad y coste eficiente para mantener un rendimiento sobresaliente.

### La Leyenda Negra del Modelo Pequeño
Lejos de ser "tontos", los modelos pequeños también poseen un valor innegable. Un modelo como **Qwen 3.5 0.8B**, aunque con un 48% de aciertos promedio, logró superar el umbral del medio en una prueba masiva. Al ser un examen de opcion multiple una seleccion al azar produce un 25% de acertividad, un modelo que puede ser ejecutable en dispositivos mobiles tiene una mayor probabilidad de acertar.


## Las Fracturas Culturales: Cuando el Idioma Falla

Los resultados más interesantes, pero también los más vulnerables a la especulación, radican en las fallas culturales e idiomáticas. Los LLMs son espejos de sus datos de entrenamiento, y estos reflejan un sesgo dominante.

**El Dominio del Inglés y las superpotencias:**
La mayoría de los LLMs han sido entrenados primordialmente sobre conjuntos masivos de datos en inglés. Por ende, aunque poseen una vasta capacidad lingüística, el español nivel bachillerato presenta un reto considerable, ya que muy probablemente el set de datos de  no incluye suficientes datos de español nivel bachillerato. 

Ademas ciertos modelos avanzados mostraron inconsistencias notorias en Historia de México o Geografía, materias intrínsecamente ligadas al contexto hispanoamericano. Mostrando un claro sesgo en el set de datos de utilizado.

**El Caso de los *Guardrails* y el Conocimiento Silenciado:**
Un caso cusrioso fue el modelo local **Apple Foundation**, liberado dentro del sistema operativo MacOS 27. El modelo obtuvo un 64.6% de acierto, lo cual podría parecer pobre en comparación con sus contemporáneos. Sin embargo, la principal causa no fue una falta de capacidad pura. Sus estrictos mecanismos de seguridad (*guardrails*) provocaron que el sistema se negara a responder reactivos considerados "sensibles" (particularmente en Historia e Historia de México), prefiriendo activamente la precaución a la respuesta. Este caso nos enseña que un puntaje bajo puede ser también el resultado de una resistencia éticamente programada, no necesariamente incompetencia algorítmica.

**La Deuda con la Historia Local:**
A pesar de su vasta potencia en matemáticas y física, el desempeño fluctuante frente a la Historia de México es un llamado directo a la necesidad de diversificar los corpus de entrenamiento. Un fallo en este aspecto refleja una asimetría en la representación del conocimiento global presente en el modelo.

## Conclusión: ¿Una Potente herramienta, pero imperfecta?

Este *benchmark* nos lleva a una conclusión profunda que trasciende el mero porcentaje de acierto:

**La inteligencia artificial es, hoy en día, una herramienta cognitivamente monumental que puede reproducir una proporción masiva del conocimiento a nivel bachillerato, pero está muy lejos de ser una herramienta infalible.**

1.  **La Barrera del 100%:** La diferencia entre el $95\%$ y el $100\%$ es la barrera final, igualmente presente para el código como para el intelecto humano. Ningún modelo evaluado logró ese acierto perfecto en las condiciones estándar de la prueba.
2.  **El Elemento Humano Irremplazable:** Aquellos que logran resultados casi perfectos no solo dependen de la memoria. Integran el conocimiento con razonamiento situado, intuición táctica, capacidad de autoevaluación y la metodología desplegada durante meses de preparación metódica. Estos elementos cognitivos complejos escapan al análisis probabilístico de un LLM aislado.

Lejos de temer una supremacía artificial inminente, este benchmark expone un escenario más complejo: la inclusion de IA ha en el ambito academico. Mas alla de evitar su uso, tenemos que apender a utilizarlo de manera efectiva, haiendo que modelos mas tontos produzcan resultados mas acertados. La pregunta de hoy es: si una IA puede hacer el 90% del trabajo ¿cual es el 10% faltante para un resultado exceptional?, porque si dejamos que la maquina haga todo el trabajo, que caso tiene tener un humano en el loop?
