# CI/CD & Git

Notes on pipelines, GitHub Actions, and git workflows, plus reusable workflow examples.

## Contents

- `notes/01-github-actions-basics.md` — workflow anatomy (`on`/`jobs`/`steps`),
  permissions, walking through `examples/workflows/reusable-lint.yml`, security basics.
- `notes/02-workflow-patterns.md` — path filtering, dependency caching, matrix builds,
  reusable workflows vs. composite actions.
- `notes/03-git-workflow.md` — branch/rebase/merge, undoing changes safely, commit and PR
  conventions, tag-based releases.
- `examples/workflows/` — example workflow files.

New here? Start with `notes/01-github-actions-basics.md` and read it alongside
`examples/workflows/reusable-lint.yml`.

## Validation

- `yamllint` runs on every `*.yaml`/`*.yml` change (workflow files under
  `.github/workflows/` and `examples/workflows/` are ignored — see `.yamllint.yaml` —
  because Actions expressions trip the linter).
- `actionlint` checks the example workflow files for schema and shell errors.
