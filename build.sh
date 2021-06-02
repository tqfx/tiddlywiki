#!/usr/bin/env bash

OUTPUT=$1
if [ ! $1 ]
then
    OUTPUT=build
fi

tiddlywiki . --output $OUTPUT --build
cp robots.txt $OUTPUT || ls *.txt
cp -r files $OUTPUT || exit 0
cp -r files $OUTPUT/static || exit 0
