import feedparser
import os
import re
from datetime import datetime

# Replace with your Substack feed
FEED_URL = "https://spottedape.substack.com/feed"

OUTPUT_DIR = "posts/substack"
os.makedirs(OUTPUT_DIR, exist_ok=True)

feed = feedparser.parse(FEED_URL)

def slugify(text):
    text = text.lower()
    text = re.sub(r'[^a-z0-9]+', '-', text)
    return text.strip('-')

for entry in feed.entries:
    title = entry.title
    date = datetime(*entry.published_parsed[:6]).strftime("%Y-%m-%d")
    slug = slugify(title)
    filename = f"{date}-{slug}.qmd"
    filepath = os.path.join(OUTPUT_DIR, filename)

    # Skip if already exists
    if os.path.exists(filepath):
        continue

    # Use content if available, fallback to summary
    content = entry.content[0].value if "content" in entry else entry.summary

    # Adjust images to 50% width
    # Wrap all <img> tags with inline style width:50%
    content = re.sub(r'(<img[^>]*?)>', r'\1 style="width:50%;height:50%">', content)

    with open(filepath, "w", encoding="utf-8") as f:
        f.write(f"""---
title: "{title}"
date: {date}
categories: [substack]
format: html
---

{content}
""")

print("Done syncing Substack posts.")