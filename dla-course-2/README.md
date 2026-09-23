# SLA Course V9 — iframe-first Quarto learning application

Published URL: `https://marcelmare.com/dla-course-2/`

This build is designed to occupy effectively the entire content area of a Google Sites **full-page embed**. Google Sites supplies the outer institutional shell; Quarto behaves as the learning application.

## Google Sites

1. Publish the Quarto project to `https://marcelmare.com/dla-course-2/`.
2. In Google Sites create/use a **Full page embed**.
3. Embed `https://marcelmare.com/dla-course-2/`.
4. Do not duplicate the seven Quarto learning stages as Google Sites pages.
5. Publish and test the Google Site, not only editor preview.

## Navigation behaviour

- Start → Understand → Spreadsheet Essentials → Build → Test → Decide → Reflect remains inside the iframe.
- Course links are forced to `_self`.
- Each new course page resets the iframe scroll position to the top.
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

## Intro video

Place `intro-video.mp4` in `assets/` and replace the placeholder in `index.qmd` with:

```markdown
::: {.course-video}
{{< video assets/intro-video.mp4 >}}
:::
```

## Render

From this folder:

```bash
quarto render
```

The rendered site is written to `_site/`.
