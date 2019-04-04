#!/bin/bash
set -e

if [[ -z ${1} ]]; then
  exec start-stop-daemon --start --chuid ${OPENFIRE_USER}:${OPENFIRE_USER} --exec /usr/bin/java -- \
    -server -DopenfireHome=/usr/share/openfire \
    -Dlog4j.configurationFile=/usr/share/openfire/lib/log4j2.xml \
    -Dopenfire.lib.dir=/usr/share/openfire/lib \
    -classpath /usr/share/openfire/lib/startup.jar \
    -jar /usr/share/openfire/lib/startup.jar
else
  exec "$@"
fi
