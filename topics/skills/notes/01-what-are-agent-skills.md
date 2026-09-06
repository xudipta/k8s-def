# What are Agent Skills

An **Agent Skill** is a directory containing a `SKILL.md` file — a set of instructions the
agent pulls into context only when the current task calls for it. Skills may also bundle
scripts, templates, and reference documents alongside the `SKILL.md`.

The pattern is vendor-neutral in spirit (it is just "prompt + files on disk that the model
chooses to open"), and is implemented concretely by Claude (Claude Code, claude.ai, the
Agent SDK) as folders under a `skills/` directory.

## Progressive disclosure

Skills keep the base prompt small by revealing detail in layers:

1. **Metadata** (`name` + `description`) is always in context — a few dozen tokens per
   skill. The agent uses it to decide whether the skill is relevant.
2. **`SKILL.md` body** loads only once the skill is triggered — the actual procedure,
   typically kept under ~500 lines.
3. **Bundled files** (`reference.md`, `scripts/*.py`, templates) load only if the body
   tells the agent to open or run them.

This is why a skill's `description` matters so much: it is the only thing the agent sees
when choosing, so it must state *what the skill does* and *when to use it*.

## When a skill is the right tool

Good fits:

- A repeatable procedure with steps that are easy to get subtly wrong (release process,
  a report format, a migration checklist).
- Domain knowledge the model lacks or gets stale on (an internal API, a house style guide).
- Tasks that need a helper script bundled next to the instructions.

Poor fits:

- One-off requests — just ask directly.
- Knowledge that belongs in a memory or a project doc that is always relevant.
- Anything you would rather enforce deterministically — use a hook, a lint rule, or CI.

## Related concepts

| Thing | Loaded | Scope |
| --- | --- | --- |
| Agent Skill | on demand, when relevant | a kind of task |
| System prompt / project doc | always | the whole session |
| Memory | recalled when relevant | facts about the user / project |
| MCP server | connected for the session | tools & data (see the `mcp` topic) |
