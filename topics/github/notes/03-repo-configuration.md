# Repo configuration: ownership, protection, templates

## CODEOWNERS

`.github/CODEOWNERS` maps paths to reviewers; GitHub auto-requests them on a matching PR
and (paired with a branch protection rule) can require their approval.

```text
# Default owner for everything
*               @org/maintainers

# Path-specific owners, last match wins
/topics/docker/  @alice
/topics/github/  @bob @carol
/.github/        @org/maintainers
```

This repo's own `.github/CODEOWNERS` is a real, minimal example of the same pattern —
read it alongside this note.

## Branch protection

Set on the default branch (Settings → Branches, or `gh api`/Terraform for
infrastructure-as-code control of the setting itself):

- **Require a pull request before merging** — no direct pushes, even for admins if you
  also disable "allow administrators to bypass".
- **Require status checks to pass** — name the CI jobs that must be green (e.g. this
  repo's `markdownlint`, `yamllint`); a check only appears in the list once it has run
  at least once.
- **Require approvals** — combine with CODEOWNERS so the *right* people are required,
  not just *any* approval.
- **Require linear history** — blocks merge commits, forcing squash or rebase merges.
- **Require branches to be up to date before merging** — re-runs CI against the latest
  base branch, catching a PR that's green against a stale base.

## PR and issue templates

`.github/pull_request_template.md` pre-fills every new PR's description —
`topics/github/examples/PULL_REQUEST_TEMPLATE.md` is a generic shape (summary, changes,
testing, related issues) you can adapt; this repo's own root template is a real,
topic-specific example of the same idea.

Issue **forms** (`.github/ISSUE_TEMPLATE/*.yml`) render as a structured web form instead
of a raw Markdown template — see `examples/ISSUE_TEMPLATE/bug_report.yml`:

```yaml
name: Bug report
description: Something isn't working
labels: [bug]
body:
  - type: input
    id: version
    attributes:
      label: Version
    validations:
      required: true
  - type: textarea
    id: repro
    attributes:
      label: Steps to reproduce
```

Multiple `.yml` forms can live in `.github/ISSUE_TEMPLATE/`; add a `config.yml` there
with `blank_issues_enabled: false` to force everyone through a template.

## Labels and releases

```bash
gh label create "needs-triage" --color FBCA04 --description "Not yet reviewed"
gh release create v1.2.0 --generate-notes   # notes assembled from merged PRs since the last tag
```

`--generate-notes` reads each PR's title (and a "release.yml" config, if present) to
group changes — consistent PR titles (see `01-git-fundamentals.md`) make the generated
notes readable without hand-editing.
