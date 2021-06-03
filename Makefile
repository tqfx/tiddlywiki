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

all:
	@$(CC) $(PLUGINS_SERVER) $(LISTEN)

run:
	@nohup $(CC) $(PLUGINS_SERVER) $(LISTEN) > /dev/null 2>&1 &

build:
	@$(CC) --output $(output) --build index static

clean:
	@-git checkout tiddlers/system/*.tid
	@-git clean -d -f -X

commit: clean
	@git add -A
	@git commit --amend --no-edit
