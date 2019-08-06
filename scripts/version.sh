#!/usr/bin/env bash

if [[ "$1" = "--pre" ]]
then
    npm test
elif [[ "$1" = "--post" ]]
then
    git push --tags
else
    VERSION=$1
    PATH=$(npm bin):$PATH lerna exec -- rm -rf dist
    PATH=$(npm bin):$PATH lerna exec -- npm version ${VERSION}
fi
