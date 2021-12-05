CC=tiddlywiki

output=output
host=0.0.0.0
port=8080
gzip=on

PLUGINS_SERVER += +plugins/tiddlywiki/filesystem
PLUGINS_SERVER += +plugins/tiddlywiki/tiddlyweb
LISTEN += --listen
LISTEN += host=$(host)
LISTEN += port=$(port)
LISTEN += username=$(username)
LISTEN += password=$(password)
LISTEN += gzip=$(gzip)

all: listen

.PHONY: listen build clean run

listen:
	@$(CC) $(PLUGINS_SERVER) $(LISTEN)
build:
	@git submodule update --init --recursive
	@$(CC) --output $(output) --build index static
clean:
	@-git checkout tiddlers/system/*.tid
	@-git clean -dfX
run:
	@nohup $(CC) $(PLUGINS_SERVER) $(LISTEN) >/dev/null 2>&1 &
