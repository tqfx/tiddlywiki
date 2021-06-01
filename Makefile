CC=tiddlywiki

output=output
host=0.0.0.0
port=8080
gzip=on

commit=$(shell TZ='Asia/Shanghai' date +%Y/%m/%d\ %H:%M:%S) $(shell git rev-parse HEAD)

LISTEN += --listen
LISTEN += host=$(host)
LISTEN += port=$(port)
LISTEN += username=$(username)
LISTEN += password=$(password)
LISTEN += gzip=$(gzip)

all:
	@$(CC) . $(LISTEN)

run:
	@nohup $(CC) . $(LISTEN) > /dev/null 2>&1 &

build:
	@$(CC) . --output $(output) --build

clean:
	@-git checkout tiddlers/system/*.tid
	@-git clean -d -f -X

commit: clean
	@git add -A
	@git commit --amend --no-edit

test:
	@echo $(commit)

