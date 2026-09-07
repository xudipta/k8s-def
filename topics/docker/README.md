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

- `hadolint` lints every `Dockerfile*` under this topic on change.
- A live smoke test builds `hello-nginx`, runs it, and curls it to confirm the response
  actually contains the expected content — not just that the Dockerfile is well-formed.

```bash
docker run --rm -i hadolint/hadolint < examples/hello-nginx/Dockerfile

docker build -t hello-nginx examples/hello-nginx
docker run -d --name hello-nginx -p 8080:80 hello-nginx
curl -sf http://localhost:8080 | grep -q 'hello from the cookbook'
docker rm -f hello-nginx
```
