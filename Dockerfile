FROM debian:bookworm-slim AS downloader

RUN apt-get update && \
    apt-get install -y --no-install-recommends wget ca-certificates && \
    rm -rf /var/lib/apt/lists/*

RUN wget -q https://github.com/Mudlet/Mudlet/releases/download/Mudlet-4.21.1/Mudlet-4.21.1-linux-x64.AppImage.tar && \
    tar -xf Mudlet-4.21.1-linux-x64.AppImage.tar && \
    rm -f Mudlet-4.21.1-linux-x64.AppImage.tar

RUN wget -qO /tmp/novnc.tar.gz https://github.com/novnc/noVNC/archive/refs/tags/v1.7.0.tar.gz && \
    mkdir -p /novnc && \
    tar -xzf /tmp/novnc.tar.gz --strip-components=1 -C /novnc && \
    rm -f /tmp/novnc.tar.gz

FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      bash \
      fluxbox \
      supervisor \
      tigervnc-standalone-server \
      libglib2.0-0 \
      python3-websockify && \
    rm -rf /var/lib/apt/lists/*

RUN groupadd -r mudlet -g 1000 && \
    useradd -u 1000 -r -g mudlet -m -d /mudlet -s /sbin/nologin -c "Mudlet user" mudlet && \
    chmod 755 /mudlet && \
    mkdir -p /mudlet/.vnc

COPY --from=downloader /Mudlet.AppImage /usr/games/mudlet
RUN chmod +x /usr/games/mudlet

COPY --from=downloader /novnc /usr/share/novnc

COPY --chown=mudlet:mudlet . /app
COPY --chown=mudlet:mudlet ./fluxbox/ /mudlet/.fluxbox/

ENV HOME=/mudlet \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=C.UTF-8 \
    DISPLAY=:0.0 \
    DISPLAY_WIDTH=1280 \
    DISPLAY_HEIGHT=800 \
    RUN_MUDLET=yes \
    RUN_FLUXBOX=yes \
    RUN_NOVNC=yes \
    VNC_PASSWORD=password

USER mudlet
CMD ["/app/entrypoint.sh"]
EXPOSE 5900
EXPOSE 8080
