# Skills in Claude Code

## Discovery

Claude Code loads skill metadata from, in order of precedence:

1. `.claude/skills/` in the working directory (project skills, committed)
2. `~/.claude/skills/` (personal skills)
3. skills bundled in installed plugins (`<plugin>:<skill>`)

Only `name` + `description` enter context at startup. Directory-scoped skills may be
listed with a path prefix (e.g. `apps/web:deploy`); the most specific match wins.

## Invocation

- **Automatic:** the model matches the task against skill descriptions and invokes the
  best fit. Sharp, scenario-based descriptions drive this.
- **Explicit:** the user types `/<skill-name>` (a "slash command") or asks for it by name.

Some skills run inline (instructions load into the current turn); others are configured to
run in a subagent and return only the result.

## Gating tools

`allowed-tools` in the frontmatter restricts a skill to a named set of tools while it is
active — useful for a skill that should only read and search, never write.

## Relationship to other Claude Code config

| Mechanism | Use it for |
| --- | --- |
| Skill | a procedure the agent should follow for a class of task |
| Hook (`settings.json`) | something that must run every time on an event — the harness runs it, not the model |
| Subagent (`.claude/agents/`) | delegating a task to a fresh context with its own tools |
| MCP server (`.mcp.json`) | adding tools and data sources (see the `mcp` topic) |

If a request is "*whenever X happens, do Y*", that is a hook, not a skill — a skill is
advisory, a hook is enforced.

## Checking a skill

```bash
python scripts/check_skill.py .claude/skills/*/SKILL.md
```

Claude Code also ships a `/skill-doctor` report and `claude plugin eval` for testing
plugin-bundled skills.
