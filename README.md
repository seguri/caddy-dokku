# caddy-dokku

Caddy image for Dokku's Caddy plugin.

The workflow pushes every build under three names on `ghcr.io/<owner>/custom-caddy`:

- `Major.Minor.Patch`: moves with every build of that Caddy line
- `Major.Minor.Patch-YYYYMMDD`: one build, never changes
- `latest`

## Use with Dokku

```
dokku caddy:set --global image ghcr.io/seguri/custom-caddy:Major.Minor.Patch
dokku caddy:stop && dokku caddy:start
```

## Updating

- Caddy: Dependabot opens a PR when a new `caddy` image tag exists. Merge it.
- Plugins: `xcaddy build` takes the latest release of each plugin. The weekly
  scheduled build picks them up. Pin a plugin with `--with <module>@<version>`
  in the Dockerfile.

The package is private on GHCR until you set it to public in the package settings.
A private image needs `docker login ghcr.io` on the server.

