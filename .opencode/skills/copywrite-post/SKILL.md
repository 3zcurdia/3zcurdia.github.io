---
name: copywrite-post
description: Manual-only copywriting pass that turns one raw, voice-dictated draft in _posts/ into a finished storytelling article in the blog's house voice. Keeps every key idea, verifies every checkable claim against real sources and cites them inline, brings contradictions and factual disputes to the user as questions instead of silently resolving them, and never translates the draft in any direction. Load only when the user runs /copywrite-post, or explicitly asks to copywrite, rewrite, restructure, turn a draft into an article, or "act as a copywriter" for a blog post. Do not auto-load for translation requests, writing from a blank page, or general writing help outside the blog.
compatibility: opencode
metadata:
  opencode/autoinvoke: "false"
---

# copywrite-post

Input: the path to one draft post (or `$ARGUMENTS`). If no path is given,
list the most recently modified files in `_posts/` and ask — never guess
among 30+ posts.
Output: the same file rewritten in place (front matter byte-identical), plus
a closing report: how each contradiction was resolved, a corrections table
with sources, and any open flags.

Objective: the reader should not be able to tell the draft was messy. The
finished piece keeps every idea the author cared about, arranged in an arc
people actually want to read, and never states something false. The opinions
stay the author's; the words become the blog's voice.

The draft is usually dictated speech: run-on sentences, misheard words,
ideas in the wrong order, and claims that are half-true. That mess is raw
material, not a defect to judge. Your job is to find the argument hiding in
it and stage it so a stranger leans in.

Non-goals (never do these here, even if asked): translate the draft in any
direction; change an opinion, memory or preference of the author; decide a
contradiction yourself; invent facts, numbers or quotes; edit, normalize or
"fix" the front matter or the filename; add or remove tags; write a new post
from scratch; run any build or publish step; commit.

Done means: the file is rewritten, the report was sent with the corrections
table and the open flags, and you stopped.

## The blog

Personal Jekyll blog at the project root. Read `references/blog-voice.md`
before writing — it is the distilled voice of the existing posts, with
verbatim anchors. `AGENTS.md` covers project conventions. Two posts are
worth reading as live calibration whenever they exist in the checkout:
`_posts/2026-10-06-why-spanish.md` (the author's own account of the
bilingual workflow and audience) and the most recent post by date.

## Step 0 — Recon

1. Read the draft fully. Read its front matter too: it stays byte-identical.
   If something in it looks wrong (date disagreeing with the filename,
   missing `image`, a typo in a tag), note it as an open flag — do not fix
   it. The author keeps filename typos and date drift on purpose or at least
   tolerates them; a silently "corrected" file is harder for them to diff.
2. Read `references/blog-voice.md`.
3. Read one recent post in full to calibrate rhythm and register against
   live prose, not just rules.
4. Record today's date.

## Step 1 — Idea inventory

Before writing a single sentence, list every key idea in the draft as a
numbered checklist, each classified:

- **opinion / experience / memory** — the author's; keep meaning intact,
  only the words change.
- **checkable claim** — a number, attribution, date or event; goes to
  Step 3 for verification.
- **contradiction or ambiguity** — goes to Step 2.
- **tangent** — may be condensed to a line, but never deleted silently.

This inventory is the contract for "keep the key ideas": at the end, every
item is either in the article or explicitly listed in the report as
condensed or dropped, with the reason. Ideas in dictated drafts often
appear three paragraphs apart and half-rephrased; merge duplicates into one
idea with the strongest phrasing.

## Step 2 — Contradiction gate (hard stop)

When two statements in the draft conflict, a claim conflicts with its own
cited source, or one garbled sentence could plausibly be read two ways that
lead to different articles ("the price jumps to the next *year*" vs
"next *tier*"), stop and ask the user how to resolve it. Never decide for
them — the draft is their thinking, and quietly picking an interpretation
rewrites their meaning.

Batch every open question into one round (the question tool), one question
per issue, two to four concrete options each with your recommendation
first. Each option should spell out its consequence for the article, not
just name the fix. What counts as a contradiction in practice:

- **claim vs. its source** — e.g. "Mexico produces more energy than the UK"
  resting on a per-person chart where the UK leads.
- **claim vs. reality** — e.g. "no new power plant in 10 years" while
  several were built; offer soften / reframe as perception / drop.
- **draft vs. physics or plain fact** — e.g. "an iPad is not using the
  grid"; offer fix-the-fact / remove / keep-as-written.
- **dictation garble** with two plausible readings.

While waiting on answers, do the Step 3 research — the answers and the
evidence usually arrive together.

## Step 3 — Verify and research

Full pass: every checkable claim gets checked. A blog post that states a
wrong number or a misattributed idea loses the trust the whole piece is
built on, and corrections are cheap when you hold the sources.

1. **Numbers**: go to primary data, not summaries. Our World in Data exposes
   grapher CSVs (`ourworldindata.org/grapher/<chart>.csv`) with exact
   series; Ember, IEA, official statistics bureaus and regulator pages
   (e.g. CFE tariffs) are preferred over news write-ups. Quote the number
   with its year and unit exactly as the source has it.
2. **Attributions and events**: Wikipedia settles most "who said this"
   errors (a famous one from real practice: the Kardashev scale is Nikolai
   Kardashev 1964, not Isaac Asimov); back claims with the study, agency or
   press article itself where possible.
3. **Missing data the draft gestures at**: find the source that fills the
   gap (the draft says "bigger solar radiation than Europe" — find the
   irradiation figure). Weave verified numbers into the story at the point
   of need; never dump a data paragraph.
4. **Corrections vs. author beliefs**: fix factual errors freely and cite
   them. But if the "error" is the author's lived experience or a belief
   they hold ("I don't remember any plant being built"), that goes to
   Step 2 as a question, not into your rewrite.
5. When the web search tool returns nothing, fetch sources directly: known
   URLs, and the DuckDuckGo HTML endpoint
   (`html.duckduckgo.com/html/?q=…`) works for discovery.

Cite the way the blog cites: inline markdown links with short labels
("([specs](…))"), woven into sentences. No footnotes, no bibliography.

## Step 4 — Stage the arc

Build the structure before writing. The blog's effective posts follow a
story arc, not an outline of topics:

1. **Hook** — a scene, a discovery, a "remember when", or a bold claim.
2. **Tension** — a paradox or question the reader can feel ("a rich country
   using *less* energy — how?").
3. **Personal stake** — the author's life, concrete and specific.
4. **The villain or the system** — where the friction lives.
5. **The twist** — the counterintuitive fact that reframes the story.
6. **The opportunity** — what could be, grounded in evidence.
7. **Vision + closing punch** — and stop.

Map every inventory item onto the arc. Section headings are `##`, short,
rhetorical or jokey ("Then my family ruined the mood with the electricity
bill"). No `## Conclusion` and no `## TL;DR` in new work: the piece ends on
a one-or-two sentence punch — an imperative, a pointed question, or a final
twist. Length target 800–1,500 words unless the draft demands more.

## Step 5 — Write

Read `references/blog-voice.md` and write to it. The non-negotiables:

- First person, conversational, contractions, em-dash and parenthetical
  asides. Sentence length oscillates: long analytical periods broken by
  one-line punch paragraphs ("Wrong. Your media is dying. All of it.").
- **Friendly, easy language.** A smart friend explaining over coffee, never
  a lecture. Jargon gets a one-line explanation or gets cut.
- Argument order: concrete personal artifact or anecdote → data with inline
  links → stated opinion. Steel-man the counterargument before rebutting
  ("Don't get me wrong, I think it is a cool technology. But…").
- Bold marks the key claim; blockquotes carry aphorisms or a citation;
  lists only when the content is genuinely a list.
- **Language: the draft's language. Never translate**, in either direction,
  even when the title and body are in different languages — that mixing is
  deliberate (see `why-spanish.md`). Front matter text is never translated
  or reworded. English tech terms inside Spanish prose stay un-italicized;
  the author italicizes borrowed everyday words (*nerd*, *spanglish*).
- Keep the author's Mexican/LatAm texture: CFE, UNAM, pesos, chile en
  nogada. These are identity, not decoration.

## Step 6 — Report and stop

Send one closing message with:

1. **The arc** — one line per section, so the author sees the shape.
2. **Contradictions** — each one and how the user's answer was applied.
3. **Corrections table** — `claim → what changed → source link`. This is
   what lets the author trust the rewrite without re-researching.
4. **Open flags** — front-matter/date mismatches, missing image, tag
   questions, anything you noticed but did not touch.
5. **Condensed or dropped ideas** — with the reason.

Then stop. Do not commit, do not build, do not offer to publish. If the
user disagrees with a resolution, change it — their reading of their own
draft beats yours.
