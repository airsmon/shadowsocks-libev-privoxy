#!/bin/sh

ss-local \
      -s $SERVER_HOST \
      -p $SERVER_PORT \
      -k $PASSWORD \
      -b ${LOCAL_ADDRESSS:-'0.0.0.0'} \
      -l $LOCAL_PORT \
      -m ${ENCRYPT_METHOD:-'aes-256-cfb'} \
      -u \
      $ARGS &

privoxy --no-daemon /etc/privoxy/config
