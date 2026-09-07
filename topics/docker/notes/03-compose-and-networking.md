# Compose, networking, and volumes

## Compose basics

`docker compose` runs a multi-container application from one YAML file. Good for local
dev stacks (app + database + cache) without hand-wiring `docker network`/`docker run`
commands.

```yaml
# compose.yaml
services:
  web:
    build: .
    ports:
      - "8080:80"
    environment:
      - LOG_LEVEL=debug
    depends_on:
      - db
  db:
    image: postgres:16-alpine
    volumes:
      - db-data:/var/lib/postgresql/data
    environment:
      - POSTGRES_PASSWORD=devpass

volumes:
  db-data:
```

```bash
docker compose up -d        # start everything in the background
docker compose logs -f web  # tail one service's logs
docker compose ps           # status of each service
docker compose down         # stop and remove containers (add -v to drop volumes too)
```

`depends_on` controls **start order**, not readiness — a database container can accept
connections seconds after its process starts. Use a healthcheck if a dependent service
needs to wait for real readiness:

```yaml
db:
  image: postgres:16-alpine
  healthcheck:
    test: ["CMD-SHELL", "pg_isready -U postgres"]
    interval: 2s
    retries: 10
web:
  depends_on:
    db:
      condition: service_healthy
```

## Networking

- Compose puts every service in the same project on one bridge network by default;
  services reach each other by **service name** as hostname (`db:5432`, not
  `localhost:5432`).
- `docker run` containers not in a shared network can't see each other by name — either
  put them on a user-defined network (`docker network create app-net`, then
  `--network app-net` on each `run`) or use Compose.
- Publish a port to the host only when something outside Docker needs it
  (`ports: ["8080:80"]`); container-to-container traffic never needs a published port.

## Volumes

- **Named volumes** (`db-data:` above) are managed by Docker and persist across
  `compose down` (not `down -v`). Use them for data you want to survive container
  recreation — databases, caches.
- **Bind mounts** (`./src:/app/src`) map a host path directly into the container. Useful
  for live-reloading source code in dev; avoid them for anything that needs to be
  portable or reproducible in CI.
- Data written to a container's writable layer (no volume) is lost when the container is
  removed — `docker run --rm` makes this explicit.
