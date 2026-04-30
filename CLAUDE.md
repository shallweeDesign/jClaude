# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Purpose

This is a Claude Code **skill** for building websites. It reads design inputs from `_input/` and generates complete website files into `_output/`.

## Skill Flow

1. Read all files in `_input/` — may include briefs, design specs, brand guidelines, copy, or reference images
2. Analyze the content and infer site structure, style, and tone
3. Generate a complete, self-contained website into `_output/`

## Output Conventions

- All output goes into `_output/` — never write outside this directory
- Produce self-contained HTML/CSS/JS (no build step required to open in a browser)
- Default to a single `index.html` unless multi-page structure is clearly needed
- Write styles in SCSS (`.scss`); compile to a single `style.css` linked in HTML
- Do not use frameworks or CDN dependencies unless the input explicitly requests them
- Images referenced in input should be linked relatively or embedded as base64 if small

## Input Handling

- `_input/` may be empty, sparse, or richly detailed — adapt accordingly
- If no style guidance is given, infer from the content's tone and purpose
- Treat any `.md` or `.txt` file as copy/content; treat image files as visual reference

## CSS Naming — BEM

All CSS class names must follow BEM (Block__Element--Modifier):

- **Block** — standalone component: `.card`, `.nav`, `.hero`
- **Element** — part of a block: `.card__title`, `.nav__link`
- **Modifier** — variant or state: `.card--featured`, `.nav__link--active`

Rules:
- Use lowercase with hyphens for multi-word names: `.site-header`, `.site-header__logo`
- Use SCSS `&` nesting to write BEM — but compile output stays flat in specificity:
  ```scss
  .card {
    &__title { ... }
    &--featured { ... }
  }
  ```
- One block per `.scss` partial file (e.g. `_card.scss`, `_nav.scss`); import all via `main.scss`

## Quality Bar

- Output must render correctly in a modern browser with no console errors
- Mobile-responsive by default (use CSS flexbox/grid, not fixed widths)
- Semantic HTML (`<header>`, `<main>`, `<section>`, `<footer>`, etc.)
