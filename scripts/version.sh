#!/usr/bin/env bash

VERSION=$1

PATH=$(npm bin):$PATH lerna exec -- npm version ${VERSION} && git add -A package.json
