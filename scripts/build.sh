#!/usr/bin/env bash

OUTPUT=build
SOURCE=.
FILES=files

tiddlywiki $SOURCE --output $OUTPUT --build
cp robots.txt $OUTPUT || ls *.txt
cp -r $FILES $OUTPUT || ls || exit 0
cp -r $FILES $OUTPUT/static || exit 0
