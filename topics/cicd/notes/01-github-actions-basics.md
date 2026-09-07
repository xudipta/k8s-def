# GitHub Actions basics

## Anatomy of a workflow

```yaml
name: CI
on:
  push:
    branches: [main]
  pull_request:

permissions:
  contents: read   # least privilege; widen per-job only where needed

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: "20"
      - run: npm ci
      - run: npm test
```

- **`on`** — the events that trigger a run (`push`, `pull_request`, `schedule`,
  `workflow_dispatch` for a manual button, `workflow_call` for a reusable workflow).
- **`jobs`** — run in parallel by default, in isolated runners; use `needs:` to
  sequence them.
- **`steps`** — run sequentially within a job, sharing the runner's filesystem.
  `uses:` runs a published action; `run:` runs shell commands.
- **`permissions`** — scope the job's `GITHUB_TOKEN` to the minimum it needs
  (`contents: read` for CI, `pull-requests: write` only for a job that comments on PRs).

## Try it: `examples/workflows/reusable-lint.yml`

This repo's own example is a **reusable workflow** — one another workflow can call
instead of copy-pasting steps:

```yaml
jobs:
  lint:
    uses: ./.github/workflows/reusable-lint.yml
    with:
      paths: "."
```

Read `reusable-lint.yml` alongside this: `workflow_call.inputs` declares its parameters,
and the job body is identical to a normal job.

## Security basics

- Pin actions to a major version (`actions/checkout@v4`) or, for third-party actions you
  don't fully trust, a commit SHA — a tag can be moved to point at different code.
- Never put a secret directly in a `run:` command that also touches untrusted input
  (e.g. a PR title) — pass secrets via `env:` and reference `${{ env.VAR }}` inside the
  script, not `${{ secrets.VAR }}` interpolated straight into a shell string, to avoid
  script injection from PR-controlled text.
- Store secrets in repo/environment settings, never in the workflow file.
- `pull_request` from a fork runs with a read-only token and no access to repo secrets by
  default — `pull_request_target` has repo secrets but checks out the *base* branch by
  default; be deliberate if you ever need it (see GitHub's docs on fork PR security
  before using it).
