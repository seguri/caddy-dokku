FROM caddy:2.11.4-builder AS builder
RUN xcaddy build \
    --with github.com/lucaslorentz/caddy-docker-proxy/v2 \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/caddy-dns/ovh \
    --with github.com/caddy-dns/porkbun

FROM caddy:2.11.4-alpine
COPY --from=builder /usr/bin/caddy /usr/bin/caddy
# Dokku mounts its caddy data dir `/var/lib/dokku/data/caddy` at `/data`.
# Write your own config at /var/lib/dokku/data/caddy/Caddyfile
# to have it merged by caddy-docker-proxy with per-app configurations.
# Useful to configure one wildcard certificate for all apps.
ENV CADDY_DOCKER_CADDYFILE_PATH=/data/Caddyfile
CMD ["caddy", "docker-proxy"]
