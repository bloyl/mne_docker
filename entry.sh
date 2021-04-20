#!/bin/bash
## Xvfb :99 -screen 0 1024x768x24 > /dev/null 2>&1 &
# /sbin/start-stop-daemon --start --quiet --pidfile /tmp/custom_xvfb_99.pid --make-pidfile --background --exec /usr/bin/Xvfb -- :99 -screen 0 1400x900x24 -ac +extension GLX +render -noreset
/usr/bin/Xvfb ${DISPLAY} -screen 0 ${XVFB_WHD} -ac +extension GLX +render -noreset > /dev/null 2>&1 &
sleep 3
exec "$@"
