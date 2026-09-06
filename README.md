# cookbook

A personal cookbook of notes and runnable examples across infrastructure and tooling
topics. Every topic that lives here is **validated in CI** — notes are linted, examples are
schema-checked or smoke-tested — so nothing rots silently.

## Topics

| Topic | Path | What's validated |
| --- | --- | --- |
| Kubernetes | [`topics/kubernetes/`](topics/kubernetes/) | `yamllint`, `kubeconform`, `kind` deploy + Service curl test |
| Docker / Containers | [`topics/docker/`](topics/docker/) | `hadolint` on every `Dockerfile` |
| Linux / Shell | [`topics/linux/`](topics/linux/) | `shellcheck` on every `*.sh` |
| Terraform / IaC | [`topics/terraform/`](topics/terraform/) | `terraform fmt -check`, `tflint` |
| CI/CD & Git | [`topics/cicd/`](topics/cicd/) | `actionlint` on example workflows |
| Agent Skills | [`topics/skills/`](topics/skills/) | `scripts/check_skill.py` on every `SKILL.md` |
| MCP | [`topics/mcp/`](topics/mcp/) | `jq` syntax check on example configs |

Markdown across the whole repo is checked with `markdownlint`.

## Layout

```text
topics/<topic>/
  README.md              # what the topic covers + how it's validated
  notes/NN-*.md          # prose notes
  examples/<name>/       # runnable files (manifests, Dockerfiles, scripts, .tf, ...)
```

## How validation works

A single workflow, [`.github/workflows/validate.yml`](.github/workflows/validate.yml), runs
on every push and PR to `main`. A `changes` job detects which topics/file types were
touched and runs only the relevant validators, so a docs-only change doesn't spin up a
`kind` cluster. `trivy.yml` additionally scans the repo for known vulnerabilities.

## Local checks

```bash
make venv     # one-time: create ./venv with yamllint
make lint     # yamllint all YAML
make lint-md  # markdownlint all Markdown (needs npx)
make format   # normalise YAML formatting
```

## Adding a topic

See [`CONTRIBUTING.md`](CONTRIBUTING.md).
