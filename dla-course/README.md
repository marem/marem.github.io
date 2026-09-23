# sla-course

Quarto website version of **Should We Invest in Solar? Capital Budgeting, Sensitivity Analysis and Managerial Judgement**.

## Structure

- `_quarto.yml` — website configuration
- `styles.css` — all course styling
- `index.qmd` — Start
- `understand.qmd`
- `spreadsheet-essentials.qmd`
- `build.qmd`
- `test.qmd`
- `decide.qmd`
- `reflect.qmd`
- `reviewer-rationale.qmd`
- `assets/` — instructional PNGs
- `downloads/` — learner PDFs and Excel workbooks

## Deploy at marcelmare.com/sla-course/

Copy this entire folder to the repository root as `sla-course/`.

From the repository root:

```bash
quarto render sla-course
```

If your main marcelmare.com project is already a Quarto website, you may instead integrate these pages into the parent site's navigation. This package is intentionally self-contained so it can first be tested independently.

## Intro video

The Start page contains a clearly marked placeholder. Replace it with your existing video embed. For a local MP4, place the file under `sla-course/assets/` and use:

```markdown
{{< video assets/your-intro-video.mp4 >}}
```

For YouTube/Vimeo, use the appropriate Quarto video shortcode or iframe.

## Important

The student workbook is available from Start. The completed reference workbook is linked only from Reflect.
