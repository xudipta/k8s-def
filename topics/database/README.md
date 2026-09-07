# Database / SQL

Notes and examples for relational schema design, migrations, and querying — provider-
agnostic SQL (Postgres dialect in the examples), no live database needed to validate.

## Contents

- `notes/01-schema-design-and-normalization.md` — 1NF/2NF/3NF, foreign keys and
  constraints, walking through `examples/schema/schema.sql` (with an ER diagram).
- `notes/02-migrations.md` — why migrations instead of hand-editing a schema, up/down
  pairs, running them, how they fit a deploy pipeline — walking through
  `examples/migrations/` (with a diagram).
- `notes/03-queries-and-indexing.md` — what to index and why, `EXPLAIN`, join types, the
  N+1 query problem (with a diagram).
- `examples/schema/schema.sql` — a small, normalized e-commerce schema.
- `examples/migrations/` — that same schema built up as four numbered up/down migration
  pairs.

New here? Start with `notes/01-schema-design-and-normalization.md` alongside
`examples/schema/schema.sql`.

## Validation

- `sqlfluff lint` (Postgres dialect, configured in `.sqlfluff`) covers every `*.sql`
  file under `examples/`.

```bash
sqlfluff lint topics/database/examples/
```
