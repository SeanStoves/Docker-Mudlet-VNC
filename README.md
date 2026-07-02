# mudlet-vnc

[![Build and Deploy to Docker Hub](https://github.com/SeanStoves/Docker-Mudlet-VNC/actions/workflows/docker-publish.yml/badge.svg)](https://github.com/SeanStoves/Docker-Mudlet-VNC/actions/workflows/docker-publish.yml)
![Docker Pulls](https://img.shields.io/docker/pulls/sstoves/mudlet-vnc)

Mudlet MUD client running in Docker, accessible via VNC (port 5900) or browser via noVNC (port 8080).

**Stack:** Mudlet 4.21.1 AppImage · TigerVNC · Fluxbox · noVNC 1.7.0 · supervisord · debian:bookworm-slim

## Environment Variables

| Variable | Default | Description |
|---|---|---|
| `VNC_PASSWORD` | `password` | VNC password — change this |
| `DISPLAY_WIDTH` | `1280` | Display width in pixels |
| `DISPLAY_HEIGHT` | `800` | Display height in pixels |
| `RUN_MUDLET` | `yes` | Set to `no` to skip launching Mudlet |
| `RUN_FLUXBOX` | `yes` | Set to `no` to skip launching Fluxbox |
| `RUN_NOVNC` | `yes` | Set to `no` to skip the noVNC WebSocket proxy |

## Ports

| Port | Service |
|---|---|
| `5900` | TigerVNC |
| `8080` | noVNC web interface |

## Quick Start

```yaml
services:
  mudlet:
    image: sstoves/mudlet-vnc:latest
    container_name: mudlet
    restart: unless-stopped
    environment:
      VNC_PASSWORD: changeme
      DISPLAY_WIDTH: 1280
      DISPLAY_HEIGHT: 800
    ports:
      - "5900:5900"
      - "8080:8080"
    volumes:
      - ./mudlet-config:/mudlet/.config/mudlet
    security_opt:
      - no-new-privileges:true
    cap_drop:
      - ALL
```

Open `http://localhost:8080/` in a browser or point a VNC client at port 5900.

## Volumes

| Path | Contents |
|---|---|
| `/mudlet/.config/mudlet` | Mudlet profiles and settings (persist this) |

## Hardening

- Runs as a dedicated non-root `mudlet` user (uid/gid 1000, nologin shell)
- VNC password written via `vncpasswd -f` at container startup — password never appears in the process table or environment of a running VNC subprocess
- Multi-stage build: wget and ca-certificates used only in the downloader stage, not in the final image
- `python3-pip` removed after websockify install; websockify installed with `--no-deps` to exclude the numpy/BLAS/LAPACK stack (~37MB, not needed for pure-Python VNC proxying)
- `fonts-urw-base35` and `poppler-data` force-removed post-install (pure data packages, no binary dependents, pulled in transitively)
- `cap_drop: ALL` and `no-new-privileges: true` recommended in compose (shown above)
- noVNC served from a pinned GitHub release tarball — no Node.js in the final image

## Known CVE Constraints

- **perl**: pulled transitively by `tigervnc-standalone-server` via `libfile-readbackwards-perl`. Cannot be removed without replacing the VNC server.
- **libcups2 / libgs**: pulled by `fluxbox → libimlib2 → libspectre1 → libgs10 → libcups2`. Cannot be removed without replacing the window manager.

Both chains are unpatched in Debian bookworm as of the build date. Neither service is exposed or reachable from outside the container.

## Tags

| Tag | Mudlet Version |
|---|---|
| `sstoves/mudlet-vnc:latest` | 4.21.1 |
| `sstoves/mudlet-vnc:4.21.1` | 4.21.1 |
