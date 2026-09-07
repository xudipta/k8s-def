# GitHub / Git

Notes and examples for git itself and for GitHub as a platform — the `gh` CLI, pull
requests, and repo configuration (CODEOWNERS, branch protection, issue/PR templates).

For GitHub Actions and CI/CD pipelines specifically, see [`topics/cicd/`](../cicd/README.md).

## Contents

- `notes/01-git-fundamentals.md` — everyday flow, merge vs. rebase, staging/stashing,
  undoing changes safely, commit conventions, tags/releases.
- `notes/02-github-cli-and-prs.md` — `gh` setup, the PR loop, `gh issue`, `gh api`, draft
  PRs and review requests, walking through `examples/scripts/open-pr.sh`.
- `notes/03-repo-configuration.md` — CODEOWNERS, branch protection, PR/issue templates,
  labels and releases.
- `examples/scripts/open-pr.sh` — commit, push, and open a PR in one command.
- `examples/ISSUE_TEMPLATE/bug_report.yml` — a GitHub issue form.
- `examples/PULL_REQUEST_TEMPLATE.md` — a generic PR template shape.

New here? Start with `notes/01-git-fundamentals.md`, then `notes/02-github-cli-and-prs.md`
alongside `examples/scripts/open-pr.sh`.

## Validation

- `markdownlint` covers the notes and `examples/PULL_REQUEST_TEMPLATE.md`.
- `yamllint` covers `examples/ISSUE_TEMPLATE/bug_report.yml`.
- `shellcheck` covers `examples/scripts/open-pr.sh`.

```bash
shellcheck examples/scripts/open-pr.sh
yamllint examples/ISSUE_TEMPLATE/bug_report.yml
```
