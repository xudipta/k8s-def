# Building an MCP server

## Minimal server (TypeScript SDK)

```ts
import { McpServer } from "@modelcontextprotocol/sdk/server/mcp.js";
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio.js";
import { z } from "zod";

const server = new McpServer({ name: "wordcount", version: "0.1.0" });

server.tool(
  "count_words",
  { text: z.string().describe("Text to count words in") },
  async ({ text }) => ({
    content: [{ type: "text", text: String(text.trim().split(/\s+/).length) }],
  }),
);

await server.connect(new StdioServerTransport());
```

Register it: `claude mcp add wordcount -- node ./wordcount.js`

Official SDKs exist for TypeScript, Python, Kotlin, Java, C#, Go, Ruby, Rust, PHP, Swift.

## Design guidelines

- **One domain per server.** Small, composable servers beat one that does everything.
- **Tool descriptions are the interface.** State what the tool does, when to use it, and
  what it returns. The model only has the description to go on.
- **Type every input** with JSON Schema; validate on entry.
- **Return concise text.** Paginate or summarize large results; don't dump 10k rows.
- **Name tools by action** (`create_issue`, not `issues`).

## Security checklist

- [ ] Least-privilege credentials; read-only where possible.
- [ ] No secrets in code or logs; take them from the environment.
- [ ] Treat all tool *inputs* as untrusted; treat model-facing *outputs* as something the
      model will act on — don't echo unsanitized third-party content as instructions.
- [ ] Destructive actions require an explicit confirmation argument or a dry-run default.
- [ ] Pin server dependencies; publish from a trusted registry.
- [ ] Document exactly what data leaves the machine.

## Testing

- `npx @modelcontextprotocol/inspector node ./server.js` — interactive tool/resource
  explorer.
- For Claude Code plugin-bundled servers, `claude plugin eval` runs an eval suite in a
  sandbox.
