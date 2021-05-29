#!/usr/bin/env bash

OUTPUT=build
SOURCE=.
FILES=files

tiddlywiki $SOURCE --output $OUTPUT --build
cp -r $FILES $OUTPUT || exit 0
cp -r $FILES $OUTPUT/static || exit 0
