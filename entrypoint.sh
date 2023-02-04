#!/bin/bash
# Entrypoint for the docker container.

if [[ ! -z "$SSL" ]]; then
  if [[ ! -f "${SSL_CERT}" ]]; then
    echo "SSL_CERT is not found. (Is it defined / does it exist?)"
    exit 1
  fi

  if [[ ! -f "${SSL_KEY}" ]]; then
	  echo "SSL_KEY is not found. (Is it defined / does it exist?)"
    exit 1
  fi
fi

if [[ ! -z "$SSL" ]]; then
  /opt/sslproxy/ssl-proxy-linux-amd64 -from 0.0.0.0:8888 -to 127.0.0.1:8080 -cert "${SSL_CERT}" -key "${SSL_KEY}" &
fi
SYNC_BASE=${SYNC_BASE} python -m anki.syncserver
