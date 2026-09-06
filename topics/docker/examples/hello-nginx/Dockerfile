# Minimal static site image. Kept hadolint-clean as a CI smoke test.
FROM nginx:1.27-alpine

COPY index.html /usr/share/nginx/html/index.html

EXPOSE 80

HEALTHCHECK CMD wget --quiet --tries=1 --spider http://localhost/ || exit 1
