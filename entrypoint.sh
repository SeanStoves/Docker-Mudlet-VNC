#!/bin/bash
set -ex

RUN_FLUXBOX=${RUN_FLUXBOX:-yes}
RUN_MUDLET=${RUN_MUDLET:-yes}

case $RUN_FLUXBOX in
  false|no|n|0)
    rm -f /app/conf.d/fluxbox.conf
    ;;
esac

case $RUN_MUDLET in
  false|no|n|0)
    rm -f /app/conf.d/mudlet.conf
    ;;
esac

exec supervisord -c /app/supervisord.conf
