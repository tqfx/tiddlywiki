.PHONY: serve build clean
serve:
	@tiddlywiki +plugins/tiddlywiki/filesystem +plugins/tiddlywiki/tiddlyweb --listen $(FLAGS)
build:
	@git submodule update --init --recursive
	@tiddlywiki --build index static $(FLAGS)
clean:
	@-git checkout tiddlers/system/*.tid
	@-git clean -dfX
