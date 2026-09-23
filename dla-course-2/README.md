# sla-course V8 — iframe-first Quarto course

Target: `https://marcelmare.com/sla-course/`, embedded inside the Google Site.

## Design
- Google Sites is the outer institutional/course shell.
- Quarto supplies the complete interactive learning object.
- No Quarto navbar, footer, search or TOC inside the iframe.
- Seven-step sticky internal progress/navigation bar.
- Relative internal links keep navigation inside the iframe.
- Local downloads remove Google Drive permission friction.
- Learner prediction, visited pages and reflection persist in browser `localStorage`.
- Solution workbook appears only on Reflect.

## Video
Replace the `INTRO VIDEO PLACEHOLDER` block in `index.qmd`. For a local MP4 in `assets/` use Quarto's video shortcode. For YouTube/Vimeo use a responsive iframe.

## Visual sequence
- Start: generated Western Cape industrial rooftop solar hero.
- Understand: three-proposal comparison.
- Spreadsheet Essentials: annotated spreadsheet interface.
- Build: model → management information diagram.
- Test: sensitivity crossover chart.
- Decide: deliberately minimal Financial Director briefing visual.
- Reflect: no decorative image; learner reasoning has visual priority.

## Render
From repository root: `quarto render sla-course`

## Google Sites embed
Embed `https://marcelmare.com/sla-course/` as the course object and give the embed as much vertical space as practical. The course includes an `Open course in new window` link for accessibility and full-screen use.
