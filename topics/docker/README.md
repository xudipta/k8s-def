# Docker / Containers

Notes and examples for building and running container images.

## Contents

- `notes/` — prose notes on images, layers, multi-stage builds, compose.
- `examples/hello-nginx/Dockerfile` — minimal image used to smoke-test the linter.

## Validation

`hadolint` lints every `Dockerfile*` under this topic on change.

```bash
docker run --rm -i hadolint/hadolint < examples/hello-nginx/Dockerfile
```
