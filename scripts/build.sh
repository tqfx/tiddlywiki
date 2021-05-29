#!/usr/bin/env bash

OUTPUT=build
SOURCE=.
FILES=files

tiddlywiki $SOURCE --output $OUTPUT --build
cp -r $FILES $OUTPUT
cp -r $FILES $OUTPUT/static
