FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN set -ex; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
      bash \
      fluxbox \
      net-tools \
      supervisor \
      x11vnc \
      xvfb \
      wget \
      libglib2.0-0 \
      python3-websockify; \
    wget -q https://github.com/Mudlet/Mudlet/releases/download/Mudlet-4.21.1/Mudlet-4.21.1-linux-x64.AppImage.tar; \
    tar -xf Mudlet-4.21.1-linux-x64.AppImage.tar; \
    mv Mudlet.AppImage /usr/games/mudlet; \
    chmod +x /usr/games/mudlet; \
    rm -f Mudlet-4.21.1-linux-x64.AppImage.tar; \
    wget -qO /tmp/novnc.tar.gz https://github.com/novnc/noVNC/archive/refs/tags/v1.7.0.tar.gz; \
    mkdir -p /usr/share/novnc; \
    tar -xzf /tmp/novnc.tar.gz --strip-components=1 -C /usr/share/novnc; \
    rm -f /tmp/novnc.tar.gz; \
    rm -rf /var/lib/apt/lists/*

RUN groupadd -r mudlet -g 1000 && \
    useradd -u 1000 -r -g mudlet -m -d /mudlet -s /sbin/nologin -c "Mudlet user" mudlet && \
    chmod 755 /mudlet

ENV HOME=/mudlet \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=C.UTF-8 \
    DISPLAY=:0.0 \
    DISPLAY_WIDTH=1024 \
    DISPLAY_HEIGHT=768 \
    RUN_MUDLET=yes \
    RUN_FLUXBOX=yes \
    RUN_NOVNC=yes \
    VNC_PASSWORD=password

COPY . /app
COPY ./fluxbox/ /mudlet/.fluxbox/

RUN chown 1000:1000 /mudlet/.fluxbox

USER mudlet
CMD ["/app/entrypoint.sh"]
EXPOSE 5900
EXPOSE 8080
