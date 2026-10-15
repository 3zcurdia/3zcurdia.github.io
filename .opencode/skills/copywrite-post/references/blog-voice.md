# Blog voice — luis/code/blog

Distilled from the existing posts (2015–2026). The 2025–2026 posts are the
target register; older posts show where the habits came from, not where they
are going. When a rule here conflicts with the draft's meaning, meaning
wins — voice serves the idea.

## Contents

1. [Front matter](#1-front-matter)
2. [Shape of a post](#2-shape-of-a-post)
3. [The voice](#3-the-voice)
4. [Language](#4-language)
5. [How arguments are built](#5-how-arguments-are-built)
6. [Openings](#6-openings)
7. [Closings](#7-closings)
8. [Verbatim anchors](#8-verbatim-anchors)
9. [House quirks](#9-house-quirks)

## 1. Front matter

```
layout: post
title: "…"
description: "…"
date: 2026-10-06
tags:
  - thoughts
  - energy
  - AI assisted
```

- `layout: post` always. No `categories`. Optional `image: /images/…`
  (2026 posts) and rarely `meta_description`.
- `title`: double-quoted; rhetorical question ("Should You Get an
  Engineering Degree?"), provocation ("The Enshittification of Everything"),
  or Colon-Subtitle ("AI Stress: The Human Cost of Efficiency"). Spanish or
  English, matching the body's mood.
- `description`: one-line hook in the body's language, shown as the
  subtitle under the title. English ones often use "Why …". Spanish ones
  often start "O al menos…".
- `tags`: lowercase list, 2–5 topic words (Spanish allowed), with the
  **AI-provenance tag last** — `AI assisted`, `human inspired`, `ai free`,
  `ai proffreaded`. Hand-typed; spellings vary and stay as typed.

Never rewrite front matter during a copywriting pass. Flag oddities instead.

## 2. Shape of a post

- **Length:** 700–1,100 words is typical; 2026 analysis runs 1,500–2,000;
  manifestos as short as 300. Aim 800–1,500 unless the draft says otherwise.
- **Headings:** `##` is the section level, 4–8 per post. `###` only for
  sub-examples inside analytical posts. Headings are rhetorical or jokey,
  never "Introduction"/"Conclusion" in new work.
- **Paragraphs:** 2–5 sentences, punctuated by one-line punch paragraphs.
- **Formatting:** bold for key claims; blockquotes for aphorisms and
  citations; bulleted lists only for genuine lists (checklists, criteria);
  markdown tables when comparing specs or numbers. Code blocks belong to
  tutorials only. Images live in front matter (`image:`), not inline HTML.
- **Links:** inline markdown, short labels or parenthetical
  ("([comparativa](…))"). No footnotes, no reference lists.

## 3. The voice

- **Person:** "I" narrates. "We" claims collective ground ("we need more
  energy, not less"). "You" challenges the reader directly ("So, ask
  yourself: where are you less efficient?").
- **Register:** conversational, contractions throughout, em-dash and
  parenthetical asides, sentence length swinging between fragments for
  impact ("It also sounds exactly like a scam.") and long analytical
  periods.
- **Humor and irony are signatures**, not seasoning. Understatement is
  common ("Affordable, apparently, if you have $20,000 lying around."),
  wordplay in headings ("The Uber shitperience"), mild snark at institutions
  and platforms.
- **Honest hedging:** "I'm not an expert on the subject, nor do I pretend
  to be", "no pretendo que eso sea un paper científico". The author argues
  hard and admits the limits of the claim in the same breath.
- **Rhetorical questions** are structural — in prose and as headings.

## 4. Language

- English dominated 2015–2025; since 2026 the blog alternates Spanish and
  English **by the author's mood and audience**, documented in
  `_posts/2026-10-06-why-spanish.md`. Its pipeline: dictate in English,
  draft with AI, sometimes translate to Spanish, refine.
- **A copywriting pass never translates.** Preserve whatever language each
  part is in — including an English body under a Spanish title. If a
  translation is wanted, it is a separate, explicit request.
- **Code-switching texture:** English tech terms sit un-italicized inside
  Spanish prose ("code", "mood", "training dataset"); borrowed everyday
  words get italics (*nerd*, *feeds*, *spanglish*).
- **Mexican/LatAm texture is identity, not decoration:** UNAM, CFE,
  pesos, "tía panista", chile en nogada, Cortázar, Mexico City life. Keep
  it in both languages.

## 5. How arguments are built

- **The core formula: concrete personal artifact → data → opinion.** A
  $100 ThinkCentre leads to Geekbench numbers and a spec table and ends at
  "no lo necesitas". A family conversation about the electricity bill leads
  to OWID charts and ends at "look at your roof".
- **Extended metaphors and thought experiments carry the argument:**
  McDonald's-only world, John Henry vs. the steam drill, the Kardashev
  scale, the chef's knife vs. the chef. Pick one and let it run through the
  piece.
- **Counterarguments are steel-manned first**, often with their own
  section, then rebutted: "Don't get me wrong, I think it is a cool
  technology.", "Cabe aclarar que: mínimo no es lo mismo que cómodo."
- **Evidence:** real public datasets (Steam Hardware Survey, Our World in
  Data, official statistics), named with year and figure. Concession
  blockquotes mark where the claim narrows.
- **Repeated rhetorical weapons** are welcome: "Seriously, who is this
  for?" can recur as a refrain.

## 6. Openings

Pick one and commit:

- **Second-person scenario:** "You probably have a box of CDs somewhere."
- **"Remember when…?"** — nostalgia as a trap door.
- **Thought experiment:** "Imagine a world where you can only eat at
  McDonald's…"
- **Personal anecdote:** "Hace poco compré una Lenovo ThinkCentre…",
  "A few days ago I fell into one of those internet rabbit holes…"
- **Bolded one-paragraph manifesto** (announcement posts).

No throat-clearing. The first sentence does work.

## 7. Closings

New work ends on a 1–2 sentence punch with **no closing heading**:

- **Imperative CTA:** "Start ripping tonight." / "Don't settle for
  McDonald's. Demand the chile en nogada."
- **Pointed question:** "What's your excuse?"
- **Final twist:** "Por lo que puedes esperar." / "Before you get angry at
  the price — look at your roof."
- **Aphorism blockquote** just before the end.

("## Conclusion" and "## TL;DR" belong to the tutorial era; don't add
them.)

## 8. Verbatim anchors

Short excerpts that define the voice — match this feel, not these words:

1. `2025-08-15-all-you-can-eat-is-mc-donalds.md:17` — "The food isn't bad.
   It's consistent, predictable, safe. … Reliable? Yes. Exceptional? Never."
2. `2026-02-16-software-engineers-as-a-commodity.md:37,49` — "Machines?
   Machines are cheap. They don't complain. They don't unionize. They don't
   ask for raises. … It also sounds exactly like a scam."
3. `2026-09-05-real-compute-need.md:19` — "Lo que me lleva a pensar: si una
   máquina de 100 dólares de 2018 cubre el 95% de los casos de uso, ¿para
   qué sirvió el progreso tecnológico de los últimos años?"
4. `2025-10-14-dead-of-phisical-media.md:14-16` — "You probably have a box
   of CDs somewhere. … Your entertainment is safe in the cloud, right?
   Wrong. Your media is dying. All of it."
5. `2026-10-06-why-spanish.md:23` — "Quien me lee es porque me conoce en
   persona. No pretendo ser ningún influencer, solo ser relevante para mi
   círculo."

## 9. House quirks

Leave these alone; they are deliberate or at least deliberately tolerated:

- **AI-provenance tags** on every post since 2025 (`human inspired` +
  `ai assisted`, `ai free`, …), hand-typed with occasional typos.
- **Typos in filenames are preserved forever** (`dead-of-phisical-media`,
  `the-inmortal-symbols`).
- **Date drift** between filename and front matter happens
  (`2026-06-11-raytracing-elixir.md` carries `date: 2026-07-11`). Flag it;
  never fix it silently.
- **Tag spellings vary** (`análisis` / `analisis`, `humman written`,
  `ai assited`). Same rule: flag, don't fix.
- Playful meta-endings appear in the hand-written posts (easter eggs aimed
  at LLM scrapers). If the draft has one, keep it.
