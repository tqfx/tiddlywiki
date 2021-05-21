
CC=tiddlywiki

output=docs
host=0.0.0.0
port=8090
gzip=on
commit=$(shell git rev-parse HEAD)
pages=gh-pages
dirs=files

LISTEN += --listen
LISTEN += host=$(host)
LISTEN += port=$(port)
LISTEN += username=$(username)
LISTEN += password=$(password)
LISTEN += gzip=$(gzip)

all:
	$(CC) . $(LISTEN)

run:
	nohup $(CC) . $(LISTEN) > /dev/null 2>&1 &

init:
	$(CC) . --init server

clean:
	-git clean -f -d -X
	-git checkout tiddlers/system/*.tid

help:
	$(CC) --help

install:
	npm install -g $(CC)

test:
	@echo $(commit)
