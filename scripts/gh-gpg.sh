#!/usr/bin/env bash

if [ ! "$COMMIT_GPG_ID" ] || [ ! "$COMMIT_GPG_KEY" ]
then
    exit 0
fi

echo "$COMMIT_GPG_KEY" | gpg --import -

git config user.signingkey "$COMMIT_GPG_ID"
git config commit.gpgsign  true
