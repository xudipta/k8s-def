# CI/CD & Git

Notes on pipelines, GitHub Actions, and git workflows, plus reusable workflow examples.

## Contents

- `notes/` — prose notes (branching models, release flows, caching, secrets handling).
- `examples/workflows/` — example workflow files.

## Validation

- `yamllint` runs on every `*.yaml`/`*.yml` change (workflow files under
  `.github/workflows/` and `examples/workflows/` are ignored — see `.yamllint.yaml` —
  because Actions expressions trip the linter).
- `actionlint` checks the example workflow files for schema and shell errors.
