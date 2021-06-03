#!/usr/bin/env bash

OUTPUT=$1
if [ ! $1 ]
then
    OUTPUT=build
fi

tiddlywiki +themes/tiddlywiki/readonly --output $OUTPUT --build static external-js
sed -i 's|%24%3A%2Fcore%2Ftemplates%2Ftiddlywiki5.js|tiddlywiki.js|g' build/*.*
sed -i 's|<pre>$:/themes/tiddlywiki/snowwhite</pre>|<pre>$:/themes/tiddlywiki/readonly</pre>|g' build/index.html
cp robots.txt $OUTPUT || ls *.txt
cp -r files $OUTPUT || exit 0
cp -r files $OUTPUT/static || exit 0
