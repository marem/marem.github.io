# SLA Course V9 — iframe-first Quarto learning application

Published URL: `https://marcelmare.com/dla-course-2/`

## Editing the course

- Edit lesson content in the eight top-level `.qmd` pages using Markdown headings, lists, tables, links, and inline code for formulas.
- Quarto fenced divisions (`::: class-name`) apply layout classes without HTML div tags in the lesson text.
- Keep visual styling in `styles.css`.
- Navigation is generated at render time by `includes/course-navigation.lua`, using one ordered list for progress and Previous/Next links. Shared `.qmd` includes provide insertion points; interactive form markup remains in separate partials.
- Learner-state behaviour remains in `includes/course-state.html`.
- Render with `quarto render dla-course-2`, then copy `dla-course-2/_site/.` into `docs/dla-course-2/` for the published output. The publishing workflow also performs these steps.

This build is designed to occupy effectively the entire content area of a Google Sites **full-page embed**. Google Sites supplies the outer institutional shell; Quarto behaves as the learning application.

## Google Sites

1. Publish the Quarto project to `https://marcelmare.com/dla-course-2/`.
2. In Google Sites create/use a **Full page embed**.
3. Embed `https://marcelmare.com/dla-course-2/`.
4. Do not duplicate the seven Quarto learning stages as Google Sites pages.
5. Publish and test the Google Site, not only editor preview.

## Navigation behaviour

- Start → Understand → Spreadsheet Essentials → Build → Test → Decide → Reflect remains inside the iframe.
- Course links remain in `_self`; explicit new-window utility and resource links retain `_blank`.
- Each new course page resets the iframe scroll position to the top, except explicit fragment links.
- Browser history scroll restoration is disabled for course pages so Back/Forward does not reopen halfway down a lesson.
- Downloads remain normal downloads; PDFs/resources may open separately where explicitly requested.
- The “Open course in new window” utility remains available as an accessibility/full-screen escape hatch.

## Learner state

`includes/course-state.html` stores:

- visited stages;
- initial prediction;
- final reflection;
- supported checklist state.

Storage uses `localStorage` when available, falls back to `sessionStorage`, then degrades safely to in-memory state if third-party iframe storage is restricted.

## Workbook scaffold and media

The V8 student workbook includes the reference model’s NPV formulas and cached results in `Test Assumptions!B8:E8`. Learners inspect the references, fill down and refine the crossover. Year-1 calculations and the remaining sensitivity rows stay blank. The five sheets, cell addresses and download filenames are unchanged.

The original introduction video is retained in an optional disclosure with a visual description. Review its audio and provide verified captions before claiming full media accessibility; no transcript was supplied.

## Render

From this folder:

```bash
quarto render
```

The rendered site is written to `_site/`.
