#
# Dockerfile for shadowsocks-libev
#

FROM alpine:3.13.5
LABEL maintainer="kev <noreply@datageek.info>, Sah <contact@leesah.name>"

ENV SERVER_HOST=
ENV SERVER_PORT=
ENV PASSWORD=
ENV ENCRYPT_METHOD=
ENV LOCAL_ADDRESSS=
ENV LOCAL_PORT=
ENV TIMEOUT 300
ENV TZ UTC

COPY . /tmp/repo
RUN set -ex \
 # Build environment setup
 && apk add --no-cache --virtual .build-deps \
      autoconf \
      automake \
      build-base \
      c-ares-dev \
      libcap \
      libev-dev \
      libtool \
      libsodium-dev \
      linux-headers \
      mbedtls-dev \
      pcre-dev \
 # Build & install
 && cd /tmp/repo \
 && ./autogen.sh \
 && ./configure --prefix=/usr --disable-documentation --disable-dependency-tracking \
 && make install \
 && ls /usr/bin/ss-* | xargs -n1 setcap cap_net_bind_service+ep \
 && apk del .build-deps \
 # Runtime dependencies setup
 && apk add --no-cache \
      ca-certificates \
      rng-tools \
      tzdata \
      $(scanelf --needed --nobanner /usr/bin/ss-* \
      | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
      | sort -u) \
 && rm -rf /tmp/repo

COPY ./docker/alpine/privoxy/config /etc/privoxy/config
RUN  set -ex \
  # Install Privoxy
  && apk add --no-cache \
       privoxy \
  && rm -rf /var/cache/apk/*

USER nobody

COPY ./docker/alpine/entrypoint.sh /entrypoint.sh

EXPOSE 8118

ENTRYPOINT ["/entrypoint.sh"]
