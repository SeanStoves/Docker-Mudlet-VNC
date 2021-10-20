FROM debian:buster

RUN set -ex; \
    apt-get update; \
    apt-get install -y \
      bash \
      fluxbox \
      net-tools \
      supervisor \
      x11vnc \
      xvfb \ 
      lua5.1 \
      wget \
      libglib2.0-dev \
      novnc; \
    wget https://www.mudlet.org/download/Mudlet-4.13.1-linux-x64.AppImage.tar; \
    tar -vxf Mudlet-4.13.1-linux-x64.AppImage.tar; \
    mv Mudlet.AppImage /usr/games/mudlet; \
    chmod +x /usr/games/mudlet;

RUN groupadd -r mudlet -g 1000 && useradd -u 1000 -r -g mudlet -m -d /mudlet -s /sbin/nologin -c "Mudlet user" mudlet && \
    chmod 755 /mudlet

ENV HOME=/mudlet \
    DEBIAN_FRONTEND=noninteractive \
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

USER mudlet
CMD ["/app/entrypoint.sh"]
EXPOSE 5900
EXPOSE 8080
