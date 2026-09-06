# Authoring a skill

## Layout

```text
my-skill/
  SKILL.md            # required: frontmatter + instructions
  reference.md        # optional: detail the body points to
  scripts/            # optional: helper scripts the body runs
  assets/             # optional: templates, examples, data
```

The directory name should equal the skill's `name`.

## SKILL.md frontmatter

```markdown
---
name: release-notes
description: >-
  Generate release notes from merged PRs since the last tag. Use when the user asks
  for a changelog, release notes, or "what changed since <version>".
license: MIT
allowed-tools: [Bash, Read, Grep]   # optional allowlist (Claude Code)
---
```

| Field | Rules |
| --- | --- |
| `name` | required; lowercase kebab-case; ≤ 64 chars; matches the folder name |
| `description` | required; ≤ 1024 chars; say **what** it does and **when** to use it, in the third person |
| `license` | optional; SPDX identifier |
| `allowed-tools` | optional; Claude Code only — restricts which tools the skill may use |

## Writing the body

- Lead with a one-line statement of what the skill produces.
- Give numbered steps; keep the whole body focused (aim for < 500 lines).
- Point to bundled files rather than inlining them:
  "Read `reference.md` for the full field list", "Run `scripts/collect.py <tag>`".
- Prefer scripts for anything deterministic (parsing, formatting, API calls) — the model
  is better at deciding *when* than at doing arithmetic reliably.
- Address the agent directly ("Run…", "If the tag is missing, ask the user…").

## Distributing skills (Claude Code)

- **Personal:** `~/.claude/skills/<name>/SKILL.md` — available in every project.
- **Project:** `.claude/skills/<name>/SKILL.md` — committed, shared with the team.
- **Plugin:** shipped inside a plugin; referenced as `plugin-name:skill-name`.

Claude Code auto-discovers these; no registration step.
