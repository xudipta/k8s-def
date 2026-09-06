# Getting started with CI/CD notes

Add notes as `NN-topic.md`. Keep example pipelines under `../examples/`.

## GitHub Actions tips

- Pin actions to a major version (`actions/checkout@v4`) or a commit SHA for security.
- Use `on.paths` to skip workflows when irrelevant files change; use `dorny/paths-filter`
  when you need per-job filtering within one workflow.
- Cache dependencies with `actions/cache` keyed on a lockfile hash.
- Prefer `permissions:` scoped to the minimum the job needs.
- Store secrets in repo/environment settings, never in the workflow file.

## Git workflow

```bash
git switch -c feature/x
git rebase -i main       # tidy history before opening a PR
git push -u origin HEAD
```
