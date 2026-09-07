# cookbook

A personal cookbook of notes and runnable examples across infrastructure and tooling
topics. Every topic that lives here is **validated in CI** — notes are linted, examples are
schema-checked or smoke-tested — so nothing rots silently.

📖 **Browsable docs site: <https://xudipta.github.io/cookbook/>**

## Topics

| Topic | Path | What's validated |
| --- | --- | --- |
| Kubernetes | [`topics/kubernetes/`](topics/kubernetes/README.md) | `yamllint`, `kubeconform`, `helm lint`, `kubectl kustomize`, `kind` deploy + Service curl test |
| Docker / Containers | [`topics/docker/`](topics/docker/README.md) | `hadolint` on every `Dockerfile` |
| Linux / Shell | [`topics/linux/`](topics/linux/README.md) | `shellcheck` on every `*.sh` |
| Terraform / IaC | [`topics/terraform/`](topics/terraform/README.md) | `terraform fmt -check`, `tflint` |
| CI/CD | [`topics/cicd/`](topics/cicd/README.md) | `actionlint` on example workflows |
| GitHub / Git | [`topics/github/`](topics/github/README.md) | `yamllint` on the issue form, `shellcheck` on the `gh` script |
| Agent Skills | [`topics/skills/`](topics/skills/README.md) | `scripts/check_skill.py` on every `SKILL.md` |
| MCP | [`topics/mcp/`](topics/mcp/README.md) | `jq` syntax check on example configs |
| Observability | [`topics/observability/`](topics/observability/README.md) | `promtool check config`/`rules`, `jq` on the Grafana dashboard |
| Database / SQL | [`topics/database/`](topics/database/README.md) | `sqlfluff lint` on schema + migrations |

Markdown across the whole repo is checked with `markdownlint`.

## Layout

```text
topics/<topic>/
  README.md              # what the topic covers + how it's validated
  notes/NN-*.md          # prose notes
  examples/<name>/       # runnable files (manifests, Dockerfiles, scripts, .tf, ...)
```

## How validation works

A single workflow, [`.github/workflows/validate.yml`](https://github.com/xudipta/cookbook/blob/main/.github/workflows/validate.yml), runs
on every push and PR to `main`. A `changes` job detects which topics/file types were
touched and runs only the relevant validators, so a docs-only change doesn't spin up a
`kind` cluster. `trivy.yml` additionally scans the repo for known vulnerabilities.

## Docs site

`pages.yml` publishes the topic READMEs and notes to
<https://xudipta.github.io/cookbook/> (MkDocs Material) on every push to `main`.
`scripts/build_docs.sh` assembles `site-src/` from the topic tree; `validate.yml`
strict-builds it on every docs change.

## Local checks

```bash
make venv       # one-time: create ./venv with the tooling
make lint       # yamllint all YAML
make lint-md    # markdownlint all Markdown (needs npx)
make format     # normalise YAML formatting
make docs-serve # preview the docs site at http://localhost:8000
```

## Adding a topic

See [`CONTRIBUTING.md`](CONTRIBUTING.md).
