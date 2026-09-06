# Contributing

## Adding a note to an existing topic

1. Create `topics/<topic>/notes/NN-short-title.md` (next free `NN`).
2. If it references a runnable artifact, add it under `topics/<topic>/examples/<name>/`.
3. Run the relevant local check (see below), then open a PR.

## Adding a new topic

1. Create the directory skeleton:

   ```text
   topics/<topic>/
     README.md              # copy the shape of an existing topic README:
                            #   what it covers + a "Validation" section
     notes/00-getting-started.md
     examples/               # at least one real, minimal example
   ```

2. Wire a validator into [`.github/workflows/validate.yml`](.github/workflows/validate.yml):

   - add a filter under the `changes` job (`<topic>: - 'topics/<topic>/**'`);
   - add a job gated on `needs.changes.outputs.<topic> == 'true'` that runs the
     linter/checker for that topic's file type.

3. Add a row to the **Topics** table in [`README.md`](README.md).

Keep examples **self-contained and credential-free** so CI can run them anywhere (e.g.
Terraform examples use the `local`/`random`/`null` providers, not real clouds).

## Validators and how to run them locally

| Topic | Tool | Command |
| --- | --- | --- |
| all | markdownlint | `npx markdownlint-cli2 "**/*.md"` |
| all YAML | yamllint | `make lint` |
| kubernetes | kubeconform | `kubeconform -summary -strict topics/kubernetes/examples/**/*.yaml` |
| kubernetes | kind | see `validate.yml` `k8s-kind` job |
| docker | hadolint | `docker run --rm -i hadolint/hadolint < path/to/Dockerfile` |
| linux | shellcheck | `shellcheck topics/linux/examples/scripts/*.sh` |
| terraform | terraform / tflint | `terraform fmt -check -recursive topics/terraform && tflint --recursive` |
| cicd | actionlint | `actionlint topics/cicd/examples/workflows/*.yml` |
| skills | check_skill.py | `python scripts/check_skill.py topics/skills/examples/*/SKILL.md` |
| mcp | jq | `find topics/mcp/examples -name '*.json' -o -name '.mcp.json' \| xargs -n1 jq empty` |

## Commit / PR

- Branch from `main`; don't push to `main` directly.
- Fill in the PR template (topic + which validator covers the change).
- CI must be green before merge. `@xudipta` owns review (see `.github/CODEOWNERS`).
