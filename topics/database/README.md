# Database / SQL

Notes and examples for relational schema design, migrations, and querying — provider-
agnostic SQL, Postgres dialect in the examples.

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
- A live check runs `examples/schema/schema.sql` and, separately, every migration pair
  against a real `postgres:16-alpine` service container: `schema.sql` applies cleanly;
  all four `up` migrations apply in order and produce exactly the same 4 tables; all four
  `down` migrations then apply in reverse order and leave the schema empty.

```bash
sqlfluff lint topics/database/examples/

# against a running Postgres:
psql -f topics/database/examples/schema/schema.sql
psql -c 'DROP TABLE IF EXISTS order_items, orders, products, users CASCADE;'
for f in $(ls topics/database/examples/migrations/*.up.sql | sort); do psql -f "$f"; done
for f in $(ls topics/database/examples/migrations/*.down.sql | sort -r); do psql -f "$f"; done
```
