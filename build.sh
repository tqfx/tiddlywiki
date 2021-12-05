#!/usr/bin/env bash

OUTPUT=$1
if [ ! $1 ]
then
    OUTPUT=build
fi

git submodule update --init --recursive
tiddlywiki +themes/tiddlywiki/readonly --output $OUTPUT --build static external-js
sed -i 's|"files/|"../files/|g' $OUTPUT/static/*.html
sed -i 's|"favicon.ico"|"files/images/favicon.png"|g' $OUTPUT/static.html
sed -i 's|"favicon.ico"|"../files/images/favicon.png"|g' $OUTPUT/static/*.html
sed -i 's|%24%3A%2Fcore%2Ftemplates%2Ftiddlywiki5.js|tiddlywiki.js|g' $OUTPUT/*.*
sed -i 's|<pre>$:/themes/tiddlywiki/snowwhite</pre>|<pre>$:/themes/tiddlywiki/readonly</pre>|g' $OUTPUT/index.html
cp robots.txt $OUTPUT || ls *.txt
cp -r files $OUTPUT || exit 0
