import feedparser
import os
import re
from datetime import datetime
from bs4 import BeautifulSoup
from markdownify import markdownify as md

FEED_URL = "https://spottedape.substack.com/feed"
OUTPUT_DIR = "posts/substack"
os.makedirs(OUTPUT_DIR, exist_ok=True)

feed = feedparser.parse(FEED_URL)


def slugify(text):
    text = text.lower()
    text = re.sub(r'[^a-z0-9]+', '-', text)
    return text.strip('-')


def clean_html_to_quarto(html):
    soup = BeautifulSoup(html, "html.parser")

    # Convert figure blocks to Quarto image markdown
    for figure in soup.find_all("figure"):
        img = figure.find("img")
        caption = figure.find("figcaption")

        if img and img.get("src"):
            src = img["src"]
            cap_text = caption.get_text(strip=True) if caption else ""

            quarto_img = f'\n\n![{cap_text}]({src}){{width=80%}}\n\n'
            figure.replace_with(quarto_img)

    # Remove leftover Substack UI divs/buttons/svg
    for tag in soup(["div", "button", "svg", "source"]):
        tag.unwrap()

    cleaned_html = str(soup)

    # Convert remaining HTML to Markdown
    markdown = md(cleaned_html, heading_style="ATX")

    return markdown.strip()


for entry in feed.entries:
    title = entry.title
    date = datetime(*entry.published_parsed[:6]).strftime("%Y-%m-%d")
    slug = slugify(title)
    filename = f"{date}-{slug}.qmd"
    filepath = os.path.join(OUTPUT_DIR, filename)

    if os.path.exists(filepath):
        continue

    content_html = entry.content[0].value if "content" in entry else entry.summary
    content_markdown = clean_html_to_quarto(content_html)

    with open(filepath, "w", encoding="utf-8") as f:
        f.write(f"""---
title: "{title}"
date: {date}
categories: [substack]
format:
  html:
    toc: false
---

{content_markdown}
""")

print("Done syncing Substack posts.")
