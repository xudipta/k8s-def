# MCP (Model Context Protocol)

Notes and example configs for **MCP** — the open protocol that lets an AI agent connect to
external tools and data through a uniform interface.

## Contents

- `notes/01-mcp-overview.md` — architecture, transports, and the three primitives.
- `notes/02-mcp-in-claude-code.md` — `.mcp.json`, config scopes, `claude mcp` commands.
- `notes/03-building-a-server.md` — a minimal server and the security checklist.
- `examples/config/` — sample client configuration files.

## Validation

- `markdownlint` covers the notes.
- A `jq` syntax check runs on every JSON file under `examples/` (including the
  dot-prefixed `.mcp.json`).

```bash
find topics/mcp/examples -name '*.json' -o -name '.mcp.json' | xargs -I{} jq empty {}
```
