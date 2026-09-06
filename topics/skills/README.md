# Agent Skills

Notes and examples for **Agent Skills** — folders of instructions (and optional scripts /
resources) that an AI agent loads on demand to do a specific kind of task well.

## Contents

- `notes/01-what-are-agent-skills.md` — the concept and when to reach for one.
- `notes/02-authoring-skills.md` — the `SKILL.md` format, frontmatter, and bundled files.
- `notes/03-skills-in-claude-code.md` — how Claude Code discovers, gates, and invokes skills.
- `examples/pdf-summary/` — a minimal skill (instructions only).
- `examples/release-notes/` — a skill that bundles a helper script.

## Validation

- `markdownlint` covers the notes.
- `scripts/check_skill.py` validates every `examples/**/SKILL.md`: frontmatter present,
  `name` is kebab-case ≤ 64 chars and matches the folder, `description` present ≤ 1024
  chars, and a non-empty body.

```bash
python scripts/check_skill.py topics/skills/examples/*/SKILL.md
```
