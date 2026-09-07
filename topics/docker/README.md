# Docker / Containers

Notes and examples for building and running container images.

## Contents

- `notes/01-images-and-dockerfiles.md` — layers, the build cache, Dockerfile best
  practices, walking through `examples/hello-nginx`.
- `notes/02-multi-stage-builds-and-caching.md` — build vs. runtime stages, why the cache
  invalidates, carrying a build cache across CI runs.
- `notes/03-compose-and-networking.md` — `docker compose`, service networking, volumes vs.
  bind mounts.
- `examples/hello-nginx/Dockerfile` — minimal image used to smoke-test the linter.

New to Docker? Start with `notes/01-images-and-dockerfiles.md` and build/run
`examples/hello-nginx` alongside it.

## Validation

`hadolint` lints every `Dockerfile*` under this topic on change.

```bash
docker run --rm -i hadolint/hadolint < examples/hello-nginx/Dockerfile
```
