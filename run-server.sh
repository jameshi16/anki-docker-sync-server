#!/bin/bash
# Starts the Anki server

if [[ ! -d ".pyenv" ]]; then
	virtualenv .pyenv
	. .pyenv/bin/activate
	pip install anki
else
	. .pyenv/bin/activate
fi

export SYNC_BASE=/home/james/servers/anki-server/data
export SYNC_USER1=james:nikgay
python -m anki.syncserver
