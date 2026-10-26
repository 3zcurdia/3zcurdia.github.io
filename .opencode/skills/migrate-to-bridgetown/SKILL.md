---
name: migrate-to-bridgetown
description: Step-by-step migration of this Jekyll blog to Bridgetown, preserving every page, URL, layout and asset exactly. Produces a working bridgetown build and a GitHub Pages deploy workflow. Load only when the user runs /migrate-to-bridgetown or explicitly asks to migrate this site to Bridgetown. Do not auto-load for writing posts, editing templates, or general Jekyll help.
compatibility: opencode
metadata:
  opencode/autoinvoke: "false"
---

# migrate-to-bridgetown

Input: none. The site is the repository root. Output: the same site built by
Bridgetown instead of Jekyll, with identical URLs and identical rendered
pages (modulo the Tailwind CSS bundling and the feed path, both called out
below).

Objective: the visitor cannot tell the migration happened. Every URL keeps
working. Every page looks the same. The only visible change is that CSS and
JS are now bundled instead of loaded from CDNs.

Non-goals (never do these here, even if asked): redesign anything; change
content, titles, dates or front matter; convert Liquid to ERB; add features;
delete a post; change the domain or `CNAME`; upgrade Tailwind past v3;
commit or push without being told.

Done means: `bundle exec bridgetown build` and `yarn build` both succeed, the
URL checklist in Step 11 passes, and you report what changed and what was
verified.

Read this file top to bottom before starting. Do the steps in order. Do not
skip a step because it "looks unnecessary". Stop and ask (question tool)
whenever a step says STOP.

## The site

Personal blog at the repository root: Jekyll 4.3, Ruby `4.0.7` (pinned in
`.ruby-version` and `mise.toml`), Tailwind loaded from the CDN, deployed to
GitHub Pages with a custom domain (`CNAME`). 34 posts in `_posts/`, 2
stories in `_stories/`. `AGENTS.md` has project conventions.

Important quirks — respect them, do not "fix" them:

- `posts/index.html` lists **all** posts by looping `site.posts`. The
  `paginate: 5` in `_config.yml` is unused. Migrate the loop as-is.
- The footer block is duplicated inside `_layouts/post.html` and
  `_layouts/story.html`, and there is also an unused `_includes/footer.html`.
  Keep the duplicated block in both layouts (parity first). Deduplicating is
  a separate task, not part of migration.
- `atom.xml` is a hand-written template. Bridgetown's feed plugin writes
  `feed.xml`. You must keep `/atom.xml` working (Step 9).
- Front matter in posts and stories is never edited. Not one byte.

## Step 0 — Recon and safety

1. `git status` — the working tree must be clean. If it is not, stop and ask
   the user what to do. Never migrate on top of uncommitted work.
2. Create a branch: `git checkout -b migrate/bridgetown`.
3. Read `_config.yml`, `Gemfile`, and every file in `_layouts/`, `_includes/`,
   `src`-bound pages (`index.md`, `about.html`, `resume.md`, `404.html`,
   `posts/index.html`, `stories/index.html`, `atom.xml`).
4. Record the current post and story filenames: `ls _posts _stories > /tmp/migration-inventory.txt`.
5. Record today's date.

## Step 1 — Verify Ruby and tools

Bridgetown 2.x officially supports Ruby 3.1–3.4. The repo pins `4.0.7`.

1. Run `ruby -v`. Then run `gem install bridgetown -v '~> 2.0' --no-document`.
2. If the gem installs and `bridgetown help` works, keep Ruby `4.0.7`. If it
   fails, STOP and ask the user whether to pin Ruby `3.4` in `.ruby-version`
   and `mise.toml`. Do not change the Ruby version silently.
3. Check Node: `node -v` (need 20+) and `yarn -v`. If missing, STOP and ask.

## Step 2 — Scaffold Bridgetown beside the Jekyll tree

Do not delete Jekyll yet. Build the new tree first, verify, then clean up.

1. Run `bridgetown new /tmp/bridgetown-scaffold -t erb --skip-bundle --skip-git`.
   (`-t erb` only sets the default; we still keep Liquid. Do not use the
   output's `.erb` files.)
2. Copy into the repo root these scaffold entries ONLY:
   `package.json`, `esbuild.config.js`, `postcss.config.js`,
   `bin/` (if present), `Rakefile` (if present), `config/` (if present).
3. Create `src/` and `frontend/` directories in the repo root. Copy the
   scaffold's `frontend/` contents in (you will rewrite the CSS entry in
   Step 6). Copy NOTHING from scaffold `src/` — our content replaces it.
4. Do not copy scaffold `Gemfile` over ours yet; Step 3 writes ours.
5. Delete `/tmp/bridgetown-scaffold` when done copying.

## Step 3 — Gemfile and config

1. Replace the contents of `Gemfile` with exactly:

```ruby
# frozen_string_literal: true

source "https://rubygems.org"

gem "bridgetown", "~> 2.0"
gem "bridgetown-feed", "~> 2.0"
gem "bridgetown-paginate", "~> 2.0"
gem "webrick", "~> 1.8"
```

   Keep the `ruby File.read('.ruby-version').strip` line at the top if it was
   there — it was; keep it.

2. Create `bridgetown.config.yml` with this content — it is `_config.yml`
   translated, keys preserved verbatim:

```yaml
url: "http://ezcurdia.dev/"

collections:
  stories:
    output: true
    permalink: "/stories/:slug/"

pagination:
  enabled: true   # kept for parity of the gem; the posts index does not use it

index_pages:
  enabled: true

defaults:
  - scope:
      path: ""
      type: posts
    values:
      layout: post
  - scope:
      path: ""
      type: stories
    values:
      layout: story
```

   Site metadata (`author`, `title`, `email`, `description`, `social`) is NOT
   in `_config.yml` anymore. Create `src/_data/site.yml` with those exact
   values copied from the old `_config.yml` (lines 1–5 and 22–25). Templates
   that say `site.title` must keep working — Bridgetown exposes `_data/site.yml`
   as `site.metadata` AND `site.data.site`. To avoid editing every template,
   ALSO add `site_metadata` entries: put `title`, `author`, `email`,
   `description`, `url` under `site_metadata:` in `bridgetown.config.yml`,
   copied verbatim from `_config.yml`. Then `site.metadata.title` works and
   Liquid `{{ site.title }}` becomes `{{ site.metadata.title }}` — but see
   Step 5 for the mechanical find/replace rule. STOP and ask the user if this
   is unclear before editing templates.

3. Delete `_config.yml` only after Step 11 passes. Keep it until then as
   reference.

## Step 4 — Move content (byte-identical)

Use `git mv` so history is preserved. Do not edit the files.

1. `git mv _posts src/_posts`
2. `git mv _stories src/_stories`
3. `git mv _layouts src/_layouts`
4. `git mv _includes src/_partials`  (Bridgetown's include dir is `_partials`)
5. `git mv posts src/posts`
6. `git mv stories src/stories`
7. `git mv index.md src/index.md`
8. `git mv about.html src/about.html`
9. `git mv resume.md src/resume.md`
10. `git mv 404.html src/404.html`
11. `git mv atom.xml src/atom.xml` (Step 9 decides its final fate)
12. `git mv assets/images src/images`
13. `git mv favicon.ico src/favicon.ico`
14. `git mv CNAME src/CNAME`  — GitHub Pages needs it in the published root;
    Bridgetown copies `src/` files to `output/`. If the deploy step in Step 10
    publishes `output/`, `src/CNAME` is correct.
15. Leave `assets/badge.min.css`, `assets/badge.min.js`, `assets/media/` alone
    for now; `git mv assets/badge.min.css src/` and `git mv assets/badge.min.js src/`
    and `git mv assets/media src/media`. Reference URLs in templates that
    point at `/assets/badge.min.css` must be updated to the new path — grep for
    them (`grep -rn "badge" src/`) and fix ONLY the path, nothing else.
16. `_sass/_syntax-highlighting.scss`: content moves to `frontend/styles/`
    in Step 6. `git mv _sass/_syntax-highlighting.scss frontend/styles/`
    and delete the now-empty `_sass/`.

Check after: `git status` shows renames, not copies+deletes. Post count in
`src/_posts` must equal 34. Story markdown files in `src/_stories` must equal
2 (plus `.keep`). Compare with `/tmp/migration-inventory.txt`. If a count is
off, STOP and ask.

## Step 5 — Template port (Liquid stays Liquid)

Bridgetown runs Liquid out of the box. The template body mostly works, but
these replacements are REQUIRED. Do them mechanically, one rule at a time,
across `src/_layouts/`, `src/_partials/`, `src/posts/`, `src/stories/`,
`src/*.html`, `src/*.md`, `src/atom.xml`:

1. `{% include X.html %}` → `{% render "X.html" %}` (or move the include body
   inline). `_includes/time_render.html` is included from `post.html`; replace
   that include with `{% partial "time_render.html" %}`.
2. `{{ site.title }}` → `{{ site.metadata.title }}`; same for
   `site.description`, `site.author`, `site.url`. The `site.social.github`
   style keys live in `src/_data/site.yml`, so they become
   `{{ site.data.site.social.github }}`. Verify with
   `grep -rn "site\." src/` that no old-style access remains.
3. `| relative_url` and `| absolute_url` keep working in Bridgetown — leave
   them.
4. `{{ site.time | date: '%Y' }}` in the footer → `{{ "now" | date: "%Y" }}`.
   Bridgetown has no `site.time`.
5. `layout: base` / `default` / `home` / `page` / `post` / `story` front
   matter stays as-is; the files moved to `src/_layouts/` with the same names.
6. `layout: null` in `atom.xml` → handled in Step 9.
7. Asset paths: `{{ "/assets/images/glacier.png" | relative_url }}` (in
   `default.html` hero) and every `/assets/images/...` reference must become
   `/images/...` because the files moved to `src/images/`. Fix every hit from
   `grep -rn "assets/images" src/`.
8. `src/about.html` uses `http://www.github.com/{{site.social.github}}.png` —
   leave the URL, just apply rule 2 to the variable.

Do not reformat, reindent, or prettify. Diffs must show only the changes
these rules require.

## Step 6 — Frontend: Tailwind + JS bundling

This is the real payoff. The CDN Tailwind in `_layouts/base.html` must go.

1. `npm install` (or `yarn`) to get the scaffold's esbuild/postcss toolchain,
   then `npm install tailwindcss@3 @tailwindcss/typography --save-dev` plus
   `npm install moment` if Step 6.4 keeps the date formatting.
2. Create `frontend/styles/index.css`:

```css
@tailwind base;
@tailwind components;
@tailwind utilities;
```

   Then append the `<style type="text/tailwindcss">` block contents from the
   old `base.html` (the `@layer base` body font and the `@media print`
   utilities), converted to plain CSS: keep the print rules as a normal
   `@media print { ... }` block, keep the body font rule.
3. Create `tailwind.config.js` copying the `tailwind.config` object that was
   inline in `base.html`: colors `columbia-blue #D4EBFA`, `oxford-blue
   #0F2945`, `indigo-dye #1C476C`, fontFamily `sans: ["Inter","system-ui",
   "sans-serif"]`, content globs `./src/**/*.{html,md,liquid}`, plugins:
   `require("@tailwindcss/typography")`.
4. `frontend/javascript/index.js`: move the mobile-menu script from
   `default.html` (the `DOMContentLoaded` block) here verbatim. Then check
   `_partials/time_render.html`: it loads jQuery + moment from CDNs and
   rewrites `<time>` tags. Run `grep -rn "<time" src/` — if there are no
   `<time>` tags in content, DELETE the partial and its include call. If
   there ARE some, keep the behavior: `npm install moment`, rewrite the
   partial as a plain-JS module in `frontend/javascript/index.js` using
   `import moment from "moment"` and `document.querySelectorAll("time")`. No
   jQuery. STOP and ask the user before removing jQuery/moment.
5. FontAwesome stays a CDN `<script>` in `base.html` for parity — do not
   self-host it now.
6. In `src/_layouts/base.html`:
   - Delete the `<script src="https://cdn.tailwindcss.com?plugins=typography">` tag.
   - Delete the inline `tailwind.config = {...}` `<script>`.
   - Delete the `<style type="text/tailwindcss">` block.
   - Keep the Google Fonts `<link>` tags as they are.
   - Add `{% stylesheet_link_tag %}` and `{% javascript_include_tag %}` where
     the CDN script was (head for CSS, end of body for JS) — verify the exact
     helper names against the scaffold's `layouts` example if they differ;
     STOP and ask if the scaffold uses different helpers.
7. Syntax highlighting: rename `frontend/styles/_syntax-highlighting.scss` to
   `syntax-highlighting.scss` (or keep the underscore if the build imports
   partials) and `@import` it from `frontend/styles/index.css`. Rouge class
   names (`.highlight`, `.k`, `.c`) are unchanged in Bridgetown output.

## Step 7 — Layouts sanity

1. `src/_layouts/base.html`: the `<head>` meta block (OG/Twitter/canonical,
   lines 5–63 of the original) is preserved verbatim except for the Step 5
   variable rules and the Step 6 script/style swaps.
2. `src/_layouts/post.html` and `story.html` keep their duplicated footer
   blocks. Do not touch `_partials/footer.html` beyond the Step 5 rules.
3. `src/_layouts/page.html`, `home.html`, `default.html`: Step 5 rules only.

## Step 8 — Index pages and permalinks

1. `src/posts/index.html` keeps looping ALL posts (`{% for post in
   site.posts %}` → in Bridgetown: `collections.posts.resources` or keep
   `site.posts` if your Bridgetown version maps it; the safest portable form
   is `{% for post in collections.posts.resources %}` and then
   `post.data.title`, `post.data.date`, `post.relative_url`, `post.content`,
   `post.data.subtitle`, `post.data.description`). Map `post.excerpt` to
   `post.data.description | default: post.description` only if a
   `description` exists in front matter — check a sample post first. STOP and
   ask the user how excerpts should render if front matter has no
   description/excerpt field.
2. `src/stories/index.html` and `src/_layouts/home.html`: same loop mapping
   for `site.stories` → `collections.stories.resources`.
3. Permalinks to preserve exactly (verify at the end): `/`, `/posts/`,
   `/stories/`, `/stories/<slug>/`, `/about/`, `/about/resume`, `/404.html`,
   `/atom.xml` (Step 9), `/feed.xml`.
4. `src/resume.md` has `permalink: /about/resume` (no trailing slash) and
   `layout: page` — keep both. Its print button and `no-print`/`page-break`
   classes must survive (they are in the CSS of Step 6.2).

## Step 9 — Feed

1. Add `bridgetown-feed` to the Gemfile (already there in Step 3) and add to
   `bridgetown.config.yml` under `plugins` if the version requires it
   (`feed` key with `path: feed.xml` mirrors the old `_config.yml` `feed:`
   block).
2. The old hand-written `src/atom.xml` produced entries with
   `post.content | xml_escape` and `site.author.name/email`. Decide with the
   user (question tool): **(a)** drop `atom.xml` and use `feed.xml` only,
   adding a `feed.xml` → `atom.xml` note in the report; or **(b)** keep the
   hand-written `src/atom.xml`, ported with Step 5 rules, AND add `feed.xml`
   from the plugin. Recommended: (b) — it guarantees byte-compatible output
   at the existing URL. Do not decide silently.
3. If (b): port `src/atom.xml` with the Step 5 rules (`layout: null` works in
   Bridgetown as `layout: none` or leaving front matter with no layout key —
   verify which; STOP and ask if unsure).

## Step 10 — Build, deploy, and cleanup

1. `bundle install`.
2. `yarn build` (or `npm run build`) — must finish with no errors.
3. `bundle exec bridgetown build` — must finish with no errors and produce
   `output/`.
4. Create `.github/workflows/deploy.yml`:

```yaml
name: Deploy to GitHub Pages
on:
  push:
    branches: [main]
permissions:
  contents: read
  pages: write
  id-token: write
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: ruby/setup-ruby@v1
        with:
          ruby-version: "4.0.7"
          bundler-cache: true
      - uses: actions/setup-node@v4
        with:
          node-version: 20
          cache: yarn
      - run: yarn install --frozen-lockfile
      - run: yarn build
      - run: bundle exec bridgetown build
      - uses: actions/upload-pages-artifact@v3
        with:
          path: output
  deploy:
    needs: build
    runs-on: ubuntu-latest
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    steps:
      - id: deployment
        uses: actions/deploy-pages@v4
```

   Adjust the Ruby version line if Step 1 changed it. If the repo currently
   deploys with the classic Pages Jekyll build (no workflow), tell the user
   they must switch the repo's Pages setting to "GitHub Actions" — STOP and
   confirm before assuming.
5. Update `.github/dependabot.yml`: add an `npm` ecosystem entry alongside
   the existing `bundler` one. Do not remove the bundler entry.
6. `.gitignore`: add `output/`, `node_modules/`, `.bridgetown-cache/` (keep
   the existing `_site`, `.jekyll-cache` entries for now).
7. Delete only after Step 11 passes: `_config.yml`, `_site/`,
   `.jekyll-cache/`, `.jekyll-metadata`, `_sass/` if empty, `Gemfile.lock`
   then `bundle install` to regenerate it, and the Jekyll lines in
   `Gemfile` (already replaced in Step 3).
8. Update `README.md` build commands (`bundle exec bridgetown build`,
   `yarn build`) and `AGENTS.md` project description. Do not change
   `AGENTS.md`'s content guidelines.

## Step 11 — Verification (hard gate)

Run `bundle exec bridgetown serve` in the background and check every URL
below. For each, confirm HTTP 200 (404 page for the 404 URL) and visually
compare against the Jekyll output you recorded in Step 0 — if you have the
old `_site/` still present when you get here, diff the HTML.

- `/` — hero with `glacier.png`, 4 latest posts, 2 recent stories.
- `/posts/` — full post list, newest first.
- One post from each era: `/2015/...`, `/2023/...`, `/2026/...` (use actual
  slugs from `src/_posts`). Check tags, dates, share buttons, back links,
  footer.
- `/stories/`, and both story pages under `/stories/<slug>/`.
- `/about/`, `/about/resume` (print styles: `no-print` hides print link and
  nav; `page-break` forces page break).
- `/404.html`.
- `/atom.xml` and `/feed.xml` — valid XML, entries present.
- View source on `/`: Google Fonts link, no `cdn.tailwindcss.com`, bundled
  CSS/JS tags present, OG/Twitter/canonical meta intact.
- Mobile menu toggles (the bundled JS).
- Syntax highlighting: open a post with code blocks (grep for `highlight` or
  fenced code in `src/_posts`) and confirm the code block is styled.

Every check must pass. If one fails, fix it and re-run the whole list.

## Step 12 — Report and stop

Send one closing message with:

1. **URLs verified** — the checklist with pass/fail.
2. **Files moved** — summary of `git mv` renames.
3. **Template changes** — the Step 5/6 rules applied, with counts.
4. **Decisions taken** — feed approach (9.2), excerpt handling (8.1),
   jQuery/moment removal (6.4), Ruby version (1.2), each with the user's
   answer.
5. **Cleanup** — what was deleted and what remains.
6. **Open flags** — anything you noticed but did not touch (duplicate
   footers, `paginate` config, unused `assets/media`, mixed http/https URLs
   like `http://ezcurdia.dev/` and `http://www.linkedin.com`).

Then stop. Do not commit or push unless the user says so.
