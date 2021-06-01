#!/usr/bin/env bash

git config user.name       "github-actions[bot]"
git config user.email      "59302530+tqfx@users.noreply.github.com"
git config core.autocrlf   input
git config core.quotepath  false
git config core.filemode   false
git config core.ignorecase false
git config --list
