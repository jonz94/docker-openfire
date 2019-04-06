FROM ubuntu:bionic

LABEL maintainer="jody16888@gmail.com"

ENV OPENFIRE_VERSION=4.3.2 \
    OPENFIRE_USER=openfire

# Add our user and group first to make sure their IDs get assigned consistently,
# regardless of whatever dependencies get added
RUN groupadd -r ${OPENFIRE_USER}; \
    useradd -r -g ${OPENFIRE_USER} ${OPENFIRE_USER}

# Install dependencies
RUN set -ex; \
    apt-get update -qy; \
    apt-get install -qy --no-install-recommends openjdk-8-jre-headless; \
    rm -rf /var/lib/apt/lists/*

# Download and install openfire
RUN set -ex; \
    apt-get update -qy; \
    apt-get install -qy --no-install-recommends wget; \
    url="http://download.igniterealtime.org/openfire/openfire_${OPENFIRE_VERSION}_all.deb"; \
    wget -qO /tmp/openfire_${OPENFIRE_VERSION}_all.deb $url; \
    dpkg -i /tmp/openfire_${OPENFIRE_VERSION}_all.deb; \
    rm -rf /tmp/openfire_${OPENFIRE_VERSION}_all.deb; \
    apt-get purge -y --auto-remove wget; \
    rm -rf /var/lib/apt/lists/*

EXPOSE 3478/tcp \
       3479/tcp \
       5222/tcp \
       5223/tcp \
       5229/tcp \
       7070/tcp \
       7443/tcp \
       7777/tcp \
       9090/tcp \
       9091/tcp

VOLUME ["/etc/openfire", "/var/lib/openfire", "/var/log/openfire"]

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod 755 /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]
