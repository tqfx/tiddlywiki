
CC=tiddlywiki

output=docs
host=0.0.0.0
port=8090
gzip=on
commit=$(shell TZ='Asia/Shanghai' date +%Y/%m/%d\ %H:%M:%S)
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

build:
	$(CC) . --output $(output) --build index

static:
	$(CC) . --output $(output) --rendertiddlers '[!is[system]]' '$$:/core/templates/static.tiddler.html' static text/plain
	$(CC) . --output $(output) --rendertiddler '$$:/core/templates/static.template.html' static.html text/plain
	$(CC) . --output $(output) --rendertiddler '$$:/core/templates/static.template.css' static/static.css text/plain

init:
	$(CC) . --init server

clean:
	-rm -rf $(output)
	-git checkout tiddlers/system/*.tid

help:
	$(CC) --help

install:
	npm install -g $(CC)

push:
	@-git add -A
	@-git commit -m "$(commit)"
	@-git fetch origin master
	@-git merge origin/master
	@-git push origin master

deloy:
	$(CC) . --output .$(output) --build index
	$(CC) . --output .$(output) --rendertiddlers '[!is[system]]' '$$:/core/templates/static.tiddler.html' static text/plain
	$(CC) . --output .$(output) --rendertiddler '$$:/core/templates/static.template.html' static.html text/plain
	$(CC) . --output .$(output) --rendertiddler '$$:/core/templates/static.template.css' static/static.css text/plain

	-mv -t .$(output) $(dirs)

	@bash -c 'for i in `ls -A`; do \
	if [ "$$i" == ".git" ]; then continue; fi;\
	if [ "$$i" == ".$(output)" ]; then continue; fi;\
	rm -rf $$i; echo "rm -rf $$i"; done'

	@bash -c 'for i in `ls -A .$(output)`; do \
	mv -t . .$(output)/$$i; echo "mv -t . .$(output)/$$i"; done'

	-rmdir .$(output)
	-cp -t static -r $(dirs)

	git checkout --orphan $(pages)
	git add -A
	git commit -s -q -m "$(commit)"
	git push -f origin $(pages)
	git checkout -
	git branch -D $(pages)

test:
	@echo $(commit)
