# Getting started with Docker notes

Drop notes here as `NN-topic.md` (e.g. `01-multi-stage-builds.md`). Keep runnable
artifacts — `Dockerfile`s, `compose.yaml` — under `../examples/<name>/`.

## Quick reference

```bash
docker build -t myapp:dev .
docker run --rm -p 8080:80 myapp:dev
docker image ls
docker system prune -f
```

## Dockerfile tips

- Pin base image tags (`nginx:1.27-alpine`, not `nginx:latest`).
- Order instructions least- to most-frequently-changing to reuse layer cache.
- One `RUN` for a related set of commands; clean up in the same layer.
- Run as a non-root `USER` where possible.
