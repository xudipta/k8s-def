---
name: pdf-summary
description: >-
  Summarize a PDF into a one-page brief with key points, figures, and open questions.
  Use when the user shares a PDF (or a path to one) and asks for a summary, digest,
  TL;DR, or "what does this say".
license: MIT
allowed-tools: [Read, Bash]
---

# PDF summary

Produce a one-page brief from a PDF.

## Steps

1. Confirm the file path. If the PDF is longer than 40 pages, ask the user which
   sections matter before reading the whole thing.
2. Read the PDF. Note the title, authors/source, and date.
3. Extract:
   - **Thesis** — one sentence on the document's main claim or purpose.
   - **Key points** — 3–7 bullets, each a standalone takeaway.
   - **Numbers** — any figures, dates, or quantities a reader would want to cite.
   - **Open questions** — what the document leaves unresolved or unsupported.
4. Write the brief in this order: Thesis, Key points, Numbers, Open questions.
   Keep it under one page. Do not editorialize beyond what the text supports.
5. End with the source line: `<title> — <author/source>, <date>`.
