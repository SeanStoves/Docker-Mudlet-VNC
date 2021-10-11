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
      mudlet \
      luarocks; \
    luarocks --tree /usr/local/ --lua-version 5.1 install luautf8; \
    luarocks --lua-version 5.1 install lcf;

ENV HOME=/root \
    DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=C.UTF-8 \
    DISPLAY=:0.0 \
    DISPLAY_WIDTH=1024 \
    DISPLAY_HEIGHT=768 \
    RUN_MUDLET=yes \
    RUN_FLUXBOX=yes \
    VNC_PASSWORD=password
COPY . /app
CMD ["/app/entrypoint.sh"]
EXPOSE 5900
