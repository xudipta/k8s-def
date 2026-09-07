# CI/CD

Notes on pipelines and GitHub Actions, plus reusable workflow examples.

For git itself and GitHub-the-platform (the `gh` CLI, PRs, repo configuration), see
[`topics/github/`](../github/README.md).

## Contents

- `notes/01-github-actions-basics.md` — workflow anatomy (`on`/`jobs`/`steps`),
  permissions, walking through `examples/workflows/reusable-lint.yml`, security basics.
- `notes/02-workflow-patterns.md` — path filtering, dependency caching, matrix builds,
  reusable workflows vs. composite actions.
- `examples/workflows/` — example workflow files.

New here? Start with `notes/01-github-actions-basics.md` and read it alongside
`examples/workflows/reusable-lint.yml`.

## Validation

- `yamllint` runs on every `*.yaml`/`*.yml` change (workflow files under
  `.github/workflows/` and `examples/workflows/` are ignored — see `.yamllint.yaml` —
  because Actions expressions trip the linter).
- `actionlint` checks the example workflow files for schema and shell errors.
