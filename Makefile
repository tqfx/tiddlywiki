EXE=tiddlywiki
GIT=git

output=output
host=0.0.0.0
port=8080
gzip=on

LISTEN += --listen
LISTEN += host=$(host)
LISTEN += port=$(port)
LISTEN += username=$(username)
LISTEN += password=$(password)
LISTEN += gzip=$(gzip)

PLUGINS_SERVER += +plugins/tiddlywiki/filesystem
PLUGINS_SERVER += +plugins/tiddlywiki/tiddlyweb

.PHONY: listen build clean run

listen:
	@$(EXE) $(PLUGINS_SERVER) $(LISTEN)
build:
	@$(GIT) submodule update --init --recursive
	@$(EXE) --output $(output) --build index static
clean:
	@-$(GIT) checkout tiddlers/system/*.tid
	@-$(GIT) clean -dfX
run:
	@nohup $(EXE) $(PLUGINS_SERVER) $(LISTEN) >/dev/null 2>&1 &
